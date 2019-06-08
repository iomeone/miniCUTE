{-# LANGUAGE OverloadedStrings #-}
module Minicute.Types.GMachine.Instruction where

import Control.Lens.Operators
import Control.Lens.Wrapped ( _Wrapped )
import Minicute.Types.Minicute.Precedence
import Minicute.Types.Minicute.Program

import qualified Data.Map as Map

{-|
Which calling convention we gonna use?
1. Try simple one
    a. caller
        - Push arguments in caller
        - Evaluate result in caller
    b. callee
        - Update results in callee
        - Pop arguments in callee
-}

type GMachineExpression = [Instruction]
type GMachineSupercombinator = (Identifier, Int, GMachineExpression)
type GMachineProgram = [GMachineSupercombinator]

transpileProgram :: MainProgram -> GMachineProgram
transpileProgram program = program ^. _Wrapped <&> transpileSc

initialCode ::[Instruction]
initialCode = [IMakeGlobal "main", IEval]

transpileSc :: MainSupercombinator -> GMachineSupercombinator
transpileSc sc = (scBinder, scArgsLength, scInsts)
  where
    scBinder = sc ^. _supercombinatorBinder

    scInsts = sc ^. _supercombinatorBody & transpileRE scArgsEnv

    scArgsEnv = Map.fromList $ zip scArgs [0..]
    scArgsLength = length scArgs
    scArgs = sc ^. _supercombinatorArguments

{-|
Transpiler for a _R_oot _E_xpression.
-}
transpileRE :: TranspileEEnv -> MainExpression -> GMachineExpression
transpileRE env (EInteger n) = [IPushBasicValue n, IUpdateAsInteger (getEnvSize env), IReturn]
transpileRE env (EConstructor tag 0) = [IPushBasicValue tag, IUpdateAsConstructor (getEnvSize env), IReturn]
transpileRE env e@(EApplication2 (EVariableIdentifier op) _ _)
  | Just _ <- lookup op binaryIntegerPrecendenceTable
  = transpilePE env e <> [IUpdateAsInteger (getEnvSize env), IReturn]
  | Just _ <- lookup op binaryDataPrecendenceTable
  = transpilePE env e <> [IUpdateAsConstructor (getEnvSize env), IReturn]
-- Should following really use a strict expression?
transpileRE env e = transpileSE env e <> [IUpdate envSize1, IPop envSize1, IUnwind]
  where
    envSize1 = getEnvSize1 env

{-|
Transpiler for a _S_trict _E_xpression.
All instruction generated by this transpiler should put the address of a whnf node on the top of the stack.

This transpiler is not able to directly transpile variable expressions because value of variable can be a non-whnf node.
-}
transpileSE :: TranspileEEnv -> MainExpression -> GMachineExpression
transpileSE _ (EInteger n) = [IMakeInteger n]
transpileSE _ (EConstructor tag arity) = [IMakeConstructor tag arity]
transpileSE env e@(EApplication2 (EVariableIdentifier op) _ _)
  | Just _ <- lookup op binaryIntegerPrecendenceTable
  = transpilePE env e <> [IWrapAsInteger]
  | Just _ <- lookup op binaryDataPrecendenceTable
  = transpilePE env e <> [IWrapAsConstructor]
transpileSE env e = transpileNE env e <> [IEval]

{-|
Transpiler for a _P_rimitive _E_xpression.
All instruction generated by this transpiler should put a primitive value on the top of the value stack.
-}
transpilePE :: TranspileEEnv -> MainExpression -> GMachineExpression
transpilePE _ (EInteger n) = [IPushBasicValue n]
transpilePE _ (EConstructor tag 0) = [IPushBasicValue tag]
transpilePE env (EApplication2 (EVariableIdentifier op) e1 e2)
  | Just _ <- lookup op binaryPrecedenceTable
  = transpilePE env e1 <> transpilePE (addEnvOffset1 env) e2 <> [IPrimitive (getPrimitiveOperator op)]
transpilePE env e = transpileSE env e <> [IPushExtractedValue]

{-|
Transpiler for a _N_on-strict _E_xpression.
All instruction generated by this transpiler should put the address of a node on the top of the stack.
-}
transpileNE :: TranspileEEnv -> MainExpression -> GMachineExpression
transpileNE _ (EInteger n) = [IMakeInteger n]
transpileNE _ (EConstructor tag arity) = [IMakeConstructor tag arity]
transpileNE env (EVariable v)
  | Just index <- Map.lookup v env = [ICopyArgument index]
  | otherwise = [IMakeGlobal v]
transpileNE env (EApplication e1 e2)
  = transpileNE env e1 <> transpileNE (addEnvOffset1 env) e2 <> [IMakeApplication]
transpileNE _ _ = error "Not yet implemented"

type TranspileEEnv = Map.Map Identifier Int

getEnvSize1 :: TranspileEEnv -> Int
getEnvSize1 = (+ 1) . getEnvSize

getEnvSize :: TranspileEEnv -> Int
getEnvSize = Map.size

addEnvOffset1 :: TranspileEEnv -> TranspileEEnv
addEnvOffset1 = Map.map (+ 1)

addEnvOffset :: Int -> TranspileEEnv -> TranspileEEnv
addEnvOffset n = Map.map (+ n)

data Instruction
  {-|
  Basic node creating operations
  -}
  = IMakeInteger Integer
  | IMakeConstructor Integer Integer
  | IMakeApplication
  | IMakeGlobal Identifier

  {-|
  Stack based operations
  -}
  | IPop Int
  | IDig Int
  | IUpdate Int
  | ICopyArgument Int

  {-|
  Value stack based operations
  -}
  | IPushBasicValue Integer
  | IPushExtractedValue
  | IWrapAsInteger
  | IWrapAsConstructor
  | IUpdateAsInteger Int
  | IUpdateAsConstructor Int

  {-|
  Primitive operations
  -}
  | IPrimitive PrimitiveOperator

  {-|
  Node unwinding operations
  -}
  | IUnwind

  {-|
  Dump related operations
  -}
  | IEval
  | IReturn
  deriving ( Eq
           , Ord
           , Show
           )

data PrimitiveOperator
  = POAdd
  | POSub
  | POMul
  | PODiv
  deriving ( Eq
           , Ord
           , Show
           )

getPrimitiveOperator :: String -> PrimitiveOperator
getPrimitiveOperator "+" = POAdd
getPrimitiveOperator "-" = POSub
getPrimitiveOperator "*" = POMul
getPrimitiveOperator "/" = PODiv
getPrimitiveOperator _ = error "Not implemented yet"
