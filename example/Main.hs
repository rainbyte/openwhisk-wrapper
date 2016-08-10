{-# LANGUAGE OverloadedStrings #-}

module Main where

import           Data.Text (Text)
import           Network.OpenWhisk

main :: IO ()
main = openwhiskWrapper (pure . Just . id)
