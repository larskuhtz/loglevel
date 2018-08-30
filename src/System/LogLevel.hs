{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE PatternSynonyms #-}
{-# LANGUAGE UnicodeSyntax #-}

-- |
-- Module: System.LogLevel
-- Copyright: Copyright © 2018 Lars Kuhtz <lakuhtz@gmail.com>
-- License: MIT
-- Maintainer: Lars Kuhtz <lakuhtz@gmail.com>
-- Stability: experimental
--
-- Log Level Datatype
--
module System.LogLevel
( LogLevel(..)
, logLevelToText
, logLevelFromText
) where

import Control.DeepSeq

import Data.Char
import Data.String
import qualified Data.Text as T

import GHC.Generics

data LogLevel
    = Quiet
    | Error
    | Warn
    | Info
    | Debug
    | Other T.Text
    deriving (Show, Read, Eq, Ord, Generic)

instance NFData LogLevel

instance IsString LogLevel where
    fromString s = case toLower <$> s of
        "quiet" → Quiet
        "error" → Error
        "warn" → Warn
        "info" → Info
        "debug" → Debug
        _ → Other (T.pack s)

logLevelToText ∷ IsString a ⇒ LogLevel → a
logLevelToText (Other t) = fromString $ T.unpack t
logLevelToText l = fromString $ toLower <$> show l

logLevelFromText ∷ T.Text → LogLevel
logLevelFromText = fromString . T.unpack

