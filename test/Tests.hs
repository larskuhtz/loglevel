{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE UnicodeSyntax #-}

-- |
-- Module: Main
-- Copyright: Copyright © 2018 Lars Kuhtz <lakuhtz@gmail>
-- License: MIT
-- Maintainer: Lars Kuhtz <lakuhtz@gmail>
-- Stability: experimental
--
module Main
( main
) where

import Data.Bifunctor
import Data.Char
import Data.String
import qualified Data.Text as T

import System.LogLevel

main ∷ IO Int
main = sum <$> sequence
    [ test "logLevelToText" test_logLevelToText
    , test "logLevelFromText1" test_logLevelFromText1
    , test "logLevelFromText2" test_logLevelFromText2
    ]

test ∷ String → Bool → IO Int
test t True = 0 <$ putStrLn (t ++ " passed")
test t False = 1 <$ putStrLn (t ++ " failed")

logLevelText ∷ IsString a ⇒ [(LogLevel, a)]
logLevelText =
    [ (Error, "error")
    , (Quiet, "quiet")
    , (Warn, "warn")
    , (Info, "info")
    , (Debug, "debug")
    , (Other "", "")
    , (Other "Abc Xyz", "Abc Xyz")
    ]

test_logLevelToText ∷ Bool
test_logLevelToText = all check logLevelText
  where
    check ∷ (LogLevel, T.Text) → Bool
    check = uncurry (==) . first logLevelToText

test_logLevelFromText1 ∷ Bool
test_logLevelFromText1 = all check logLevelText
  where
    check = uncurry (==) . second logLevelFromText

test_logLevelFromText2 ∷ Bool
test_logLevelFromText2 = all check (init logLevelText)
    && not (check $ last logLevelText)
  where
    check = uncurry (==)
        . second (logLevelFromText . T.pack . fmap toUpper)

