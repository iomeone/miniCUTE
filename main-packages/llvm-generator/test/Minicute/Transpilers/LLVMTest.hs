{- HLINT ignore "Redundant do" -}
{- HLINT ignore "Reduce duplication" -}
{-# OPTIONS_GHC -fno-warn-name-shadowing #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE QuasiQuotes #-}
-- |
-- Copyright: (c) 2018-present Junyoung Clare Jang
-- License: BSD 3-Clause
module Minicute.Transpilers.LLVMTest
  ( spec_generateMachineCode
  ) where

import Test.Tasty.Hspec

import Control.Monad
import Data.Tuple.Extra
import LLVM.IRBuilder
import Minicute.Transpilers.LLVM
import Minicute.Transpilers.LLVM.Constants
import Minicute.Utils.GMachine.TH

import qualified LLVM.AST as AST
import qualified LLVM.AST.Type as ASTT

spec_generateMachineCode :: Spec
spec_generateMachineCode = forM_ testCases (uncurry3 generateMachineCodeTest)

generateMachineCodeTest :: TestName -> TestBeforeContent -> TestAfterContent -> SpecWith (Arg Expectation)
generateMachineCodeTest n beforeContent afterContent = do
  it ("generate a valid machine code from " <> n) $ do
    generateMachineCode beforeContent `shouldBe` afterContent

type TestName = String
type TestBeforeContent = GMachineProgram
type TestAfterContent = [AST.Definition]
type TestCase = (TestName, TestBeforeContent, TestAfterContent)

-- |
-- __TODO: Introduce an appropriate quasiquoter__
testCases :: [TestCase]
testCases
  = [ ( "an empty program"
      , [qqGMachine|
        |]
      , []
      )

    , ( "a program with an integer supercombinator"
      , [qqGMachine|
           f<0> {
             PushBasicValue 100;
             UpdateAsInteger 0;
             Return;
           }
        |]
      , execModuleBuilder emptyModuleBuilder $ do
          _ <- global "minicute__user_defined__f__node" typeNodeNGlobal $
            constantNodeNGlobal "minicute__user_defined__f__code"
          function "minicute__user_defined__f__code" [] ASTT.void . const $ do
            emitBlockStart "entry"

            -- PushBasicValue 100
            pName <- alloca ASTT.i32 Nothing 0
            store (operandInt 32 100) 0 pName
            vName <- load pName 0

            -- UpdateAsInteger 0
            sName <- load operandAddrStackPointer 0
            sName' <- gep sName [operandInteger 32 0]
            nName <- load sName' 0
            _ <- call operandNodeUpdateNInteger [(vName, []), (nName, [])]

            -- Return
            bName <- load operandAddrBasePointer 0
            bName' <- gep bName [operandInteger 32 0]
            store bName' 0 operandAddrStackPointer
            retVoid
      )

    , ( "a program with a structure supercombinator"
      , [qqGMachine|
           f<0> {
             PushBasicValue 1;
             UpdateAsStructure 0;
             Return;
           }
        |]
      , execModuleBuilder emptyModuleBuilder $ do
          _ <- global "minicute__user_defined__f__node" typeNodeNGlobal $
            constantNodeNGlobal "minicute__user_defined__f__code"
          function "minicute__user_defined__f__code" [] ASTT.void . const $ do
            emitBlockStart "entry"

            -- PushBasicValue 1
            pName <- alloca ASTT.i32 Nothing 0
            store (operandInt 32 1) 0 pName
            vName <- load pName 0

            -- UpdateAsStructure 0
            sName <- load operandAddrStackPointer 0
            sName' <- gep sName [operandInteger 32 0]
            nName <- load sName' 0
            fName <- alloca (ASTT.ArrayType 0 typeInt8Ptr) Nothing 0
            fName' <- gep fName [operandInteger 32 0, operandInteger 32 0]
            fName'' <- call operandNodeCreateNStructureFields [(operandInteger 32 0, []), (fName', [])]
            _ <- call operandNodeUpdateNStructure [(vName, []), (fName'', []), (nName, [])]

            -- Return
            bName <- load operandAddrBasePointer 0
            bName' <- gep bName [operandInteger 32 0]
            store bName' 0 operandAddrStackPointer
            retVoid
      )

    , ( "a program with an alias supercombinator"
      , [qqGMachine|
           f<0> {
             MakeGlobal g;
             Eval;
             Update 1;
             Pop 1;
             Unwind;
           }
        |]
      , execModuleBuilder emptyModuleBuilder $ do
          _ <- global "minicute__user_defined__f__node" typeNodeNGlobal $
            constantNodeNGlobal "minicute__user_defined__f__code"
          function "minicute__user_defined__f__code" [] ASTT.void . const $ do
            emitBlockStart "entry"

            -- MakeGlobal g
            sName <- load operandAddrStackPointer 0
            sName' <- gep sName [operandInteger 32 1]
            nName <- bitcast (operandNGlobal "minicute__user_defined__g__node") typeInt8Ptr
            store nName 0 sName'
            store sName' 0 operandAddrStackPointer

            -- Eval
            bName <- load operandAddrBasePointer 0
            sName <- load operandAddrStackPointer 0
            sName' <- gep sName [operandInteger 32 (negate 1)]
            store sName' 0 operandAddrBasePointer
            _ <- call operandUtilUnwind []
            store bName 0 operandAddrBasePointer

            -- Update 1
            sName <- load operandAddrStackPointer 0
            sName' <- gep sName [operandInteger 32 0]
            nName <- load sName' 0
            sName'' <- gep sName [operandInteger 32 (negate 1)]
            nName' <- load sName'' 0
            _ <- call operandNodeUpdateNIndirect [(nName, []), (nName', [])]

            -- Pop 1
            sName <- load operandAddrStackPointer 0
            sName' <- gep sName [operandInteger 32 (negate 1)]
            store sName' 0 operandAddrStackPointer

            -- Unwind
            _ <- call operandUtilUnwind []
            retVoid
      )

    , ( "a program with a single-argument supercombinator"
      , [qqGMachine|
           f<1> {
             Copy 0;
             Eval;
             Update 2;
             Pop 2;
             Unwind;
           }
        |]
      , execModuleBuilder emptyModuleBuilder $ do
          _ <- global "minicute__user_defined__f__node" typeNodeNGlobal $
            constantNodeNGlobal "minicute__user_defined__f__code"
          function "minicute__user_defined__f__code" [] ASTT.void . const $ do
            emitBlockStart "entry"

            -- Copy 0
            sName <- load operandAddrStackPointer 0
            sName' <- gep sName [operandInteger 32 0]
            nName <- load sName' 0
            sName'' <- gep sName [operandInteger 32 1]
            store nName 0 sName''
            store sName'' 0 operandAddrStackPointer

            -- Eval
            bName <- load operandAddrBasePointer 0
            sName <- load operandAddrStackPointer 0
            sName' <- gep sName [operandInteger 32 (negate 1)]
            store sName' 0 operandAddrBasePointer
            _ <- call operandUtilUnwind []
            store bName 0 operandAddrBasePointer

            -- Update 2
            sName <- load operandAddrStackPointer 0
            sName' <- gep sName [operandInteger 32 0]
            nName <- load sName' 0
            sName'' <- gep sName [operandInteger 32 (negate 2)]
            nName' <- load sName'' 0
            _ <- call operandNodeUpdateNIndirect [(nName, []), (nName', [])]

            -- Pop 2
            sName <- load operandAddrStackPointer 0
            sName' <- gep sName [operandInteger 32 (negate 2)]
            store sName' 0 operandAddrStackPointer

            -- Unwind
            _ <- call operandUtilUnwind []
            retVoid
      )

    , ( "a program with a supercombinator of an supercombinator application"
      , [qqGMachine|
           f<0> {
             MakeGlobal g;
             MakeInteger 0;
             MakeApplication;
             Eval;
             Update 1;
             Pop 1;
             Unwind;
           }
        |]
      , execModuleBuilder emptyModuleBuilder $ do
          _ <- global "minicute__user_defined__f__node" typeNodeNGlobal $
            constantNodeNGlobal "minicute__user_defined__f__code"
          function "minicute__user_defined__f__code" [] ASTT.void . const $ do
            emitBlockStart "entry"

            -- MakeGlobal g
            sName <- load operandAddrStackPointer 0
            sName' <- gep sName [operandInteger 32 1]
            nName <- bitcast (operandNGlobal "minicute__user_defined__g__node") typeInt8Ptr
            store nName 0 sName'
            store sName' 0 operandAddrStackPointer

            -- MakeInteger 0
            sName <- load operandAddrStackPointer 0
            sName' <- gep sName [operandInteger 32 1]
            nName <- call operandNodeCreateNInteger [(operandInteger 32 0, [])]
            store nName 0 sName'
            store sName' 0 operandAddrStackPointer

            -- MakeApplication
            sName <- load operandAddrStackPointer 0
            sName' <- gep sName [operandInteger 32 (negate 1)]
            fName <- load sName' 0
            sName'' <- gep sName [operandInteger 32 0]
            aName <- load sName'' 0
            nName <- call operandNodeCreateNApplication [(fName, []), (aName, [])]
            store nName 0 sName'
            store sName' 0 operandAddrStackPointer

            -- Eval
            bName <- load operandAddrBasePointer 0
            sName <- load operandAddrStackPointer 0
            sName' <- gep sName [operandInteger 32 (negate 1)]
            store sName' 0 operandAddrBasePointer
            _ <- call operandUtilUnwind []
            store bName 0 operandAddrBasePointer

            -- Update 1
            sName <- load operandAddrStackPointer 0
            sName' <- gep sName [operandInteger 32 0]
            nName <- load sName' 0
            sName'' <- gep sName [operandInteger 32 (negate 1)]
            nName' <- load sName'' 0
            _ <- call operandNodeUpdateNIndirect [(nName, []), (nName', [])]

            -- Pop 1
            sName <- load operandAddrStackPointer 0
            sName' <- gep sName [operandInteger 32 (negate 1)]
            store sName' 0 operandAddrStackPointer

            -- Unwind
            _ <- call operandUtilUnwind []
            retVoid
      )
    ]
