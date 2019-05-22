{- HLINT ignore "Redundant do" -}
{-# LANGUAGE QuasiQuotes #-}
module Minicute.PrettyPrintableSpec
  ( spec
  ) where

import Test.Hspec
import Test.Hspec.Megaparsec
import Test.Minicute.Utils

import Control.Monad
import Data.Either
import Minicute.Types.Minicute.Program
import Text.Megaparsec

import qualified Minicute.Data.PrintSequence as PS
import qualified Minicute.PrettyPrintable as PP
import qualified Minicute.Parser.Parser as P

spec :: Spec
spec = do
  describe "prettyPrint" $ do
    forM_ testCases (uncurry programLTest)

programLTest :: TestName -> TestContent -> SpecWith (Arg Expectation)
programLTest name programString = do
  describe ("with " <> name) $ do
    it "prints re-parsable text" $ do
      program <- parseProgramL programString
      parse P.mainProgramL "" (PS.toString (PP.prettyPrint program)) `shouldParse` program
    it "prints expected text" $ do
      program <- parseProgramL programString
      PS.toString (PP.prettyPrint program) `shouldBe` programString
  where
    parseProgramL :: String -> IO MainProgramL
    parseProgramL ps = do
      parse P.mainProgramL "" ps `shouldSatisfy` isRight
      case parse P.mainProgramL "" ps of
        Right program -> return program
        Left e -> error (errorBundlePretty e)

type TestName = String
type TestContent = String
type TestCase = (TestName, TestContent)

testCases :: [TestCase]
testCases
  = [ ( "empty program"
      , [qqRawCode||]
      )
    , ( "simple program"
      , [qqRawCode|
                  f = 5
        |]
      )
    , ( "program with multiple top-level definitions"
      , [qqRawCode|
                  f = 5;
                  g = 5
        |]
      )
    , ( "program with top-level definitions with arguments"
      , [qqRawCode|
                  f x = g x 5;
                  g x y = x y
        |]
      )
    , ( "program with arithmetic operators"
      , [qqRawCode|
                  f = 5 + 4
        |]
      )
    , ( "program with multiple arithmetic operators0"
      , [qqRawCode|
                  f = 5 + 4 * 5
        |]
      )
    , ( "program with multiple arithmetic operators1"
      , [qqRawCode|
                  f = (5 + 4) * 5
        |]
      )
    , ( "program with multiple arithmetic operators2"
      , [qqRawCode|
                  f = 5 - 4 - 3
        |]
      )
    , ( "program with multiple arithmetic operators3"
      , [qqRawCode|
                  f = 5 - (4 - 3)
        |]
      )
    , ( "program with let"
      , [qqRawCode|
                  f = let
                        x = 5
                      in
                        x
        |]
      )
    , ( "program with match"
      , [qqRawCode|
                  f = match x with
                        <1> -> 1;
                        <2> -> 2
        |]
      )
    , ( "program with lambda"
      , [qqRawCode|
                  f = \x ->
                        x + 4
        |]
      )
    , ( "program with an application with lambda"
      , [qqRawCode|
                  f = g (\x ->
                           x + 4)
        |]
      )
    , ( "program with an application for lambda"
      , [qqRawCode|
                  f = (\x ->
                         x + 4) (5 * 3)
        |]
      )
    ]
