-- |
-- Copyright: (c) 2018-present Junyoung Clare Jang
-- License: BSD 3-Clause
--
-- Minicute syntax utilities for miniCUTE compiler using TemplateHaskell
module Minicute.Utils.Minicute.TH
  ( qqMiniMainMC
  , qqMiniMainLLMC

  , qqRawCode
  ) where

import Prelude hiding ( fail )

import Control.Monad.Fail
import Language.Haskell.TH
import Language.Haskell.TH.Quote
import Language.Haskell.TH.Syntax
import Minicute.Parser.Minicute.Parser
import Minicute.Utils.Common.TH
import Text.Megaparsec

-- |
-- parse quoted string as a 'MainProgramMC'.
qqMiniMainMC :: QuasiQuoter
qqMiniMainMC
  = QuasiQuoter
    { quoteExp = qqMiniMainExpMC
    , quotePat = const . fail $ "qqMiniMainExpMC cannot be used as a pattern"
    , quoteType = const . fail $ "qqMiniMainExpMC cannot be used as a type"
    , quoteDec = const . fail $ "qqMiniMainExpMC cannot be used as a declaration"
    }

-- |
-- parse quoted string as a 'MainProgramLLMC'.
qqMiniMainLLMC :: QuasiQuoter
qqMiniMainLLMC
  = QuasiQuoter
    { quoteExp = qqMiniMainExpLLMC
    , quotePat = const . fail $ "qqMiniMainExpLLMC cannot be used as a pattern"
    , quoteType = const . fail $ "qqMiniMainExpLLMC cannot be used as a type"
    , quoteDec = const . fail $ "qqMiniMainExpLLMC cannot be used as a declaration"
    }


qqMiniMainExpMC :: String -> Q Exp
qqMiniMainExpMC = lift . either (error . errorBundlePretty) id . parse mainProgramMC "" . normalizeCode

qqMiniMainExpLLMC :: String -> Q Exp
qqMiniMainExpLLMC = lift . either (error . errorBundlePretty) id . parse mainProgramLLMC "" . normalizeCode