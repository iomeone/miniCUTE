{- HLINT ignore "Redundant do" -}
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE QuasiQuotes #-}
-- |
-- Copyright: (c) 2018-present Junyoung Clare Jang
-- License: BSD 3-Clause
module Minicute.Transpilers.Optimizers.SimpleArithmeticTest
  ( spec_simpleArithmeticMainMC
  ) where

import Test.Tasty.Hspec

import Control.Monad
import Data.Tuple.Extra
import Minicute.Transpilers.Optimizers.SimpleArithmetic
import Minicute.Utils.Minicute.TH

spec_simpleArithmeticMainMC :: Spec
spec_simpleArithmeticMainMC
  = forM_ testCases (uncurry3 simpleArithmeticMainMCTest)

simpleArithmeticMainMCTest :: TestName -> TestBeforeContent -> TestAfterContent -> SpecWith (Arg Expectation)
simpleArithmeticMainMCTest name beforeContent afterContent = do
  it ("immediate applications are optimized in " <> name) $ do
    simpleArithmeticMainMC beforeContent `shouldBe` afterContent

type TestName = String
type TestBeforeContent = MainProgram 'Simple 'MC
type TestAfterContent = MainProgram 'Simple 'MC
type TestCase = (TestName, TestBeforeContent, TestAfterContent)

testCases :: [TestCase]
testCases
  = [ ( "program with simple arithmetics as top-level bodies"
      , [qqMiniMainMC|
                    f = 1 + 1;
                    g = 2 * 3 + 1;
                    h = (3 - 2) * 3 - 2 * 3 + 3
        |]
      , [qqMiniMainMC|
                    f = 2;
                    g = 7;
                    h = 0
        |]
      )

    , ( "program with simple arithmetics in let definitions"
      , [qqMiniMainMC|
                    f = let
                          x = 1 + 2
                        in
                          x + 3;
                    g = let
                          x = 2 * 3 + 1;
                          y = let
                                z = 3 - 2
                              in
                                id z
                        in
                          test y x (x + x)
        |]
      , [qqMiniMainMC|
                    f = let
                          x = 3
                        in
                          x + 3;
                    g = let
                          x = 7;
                          y = let
                                z = 1
                              in
                                id z
                        in
                          test y x (x + x)
        |]
      )
    ]
