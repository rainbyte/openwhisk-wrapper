{-# LANGUAGE OverloadedStrings #-}

module Main where

import           Data.Aeson (Value)
import           Network.HTTP.Types.Status (ok200)
import           Web.Scotty

main :: IO ()
main = scotty 8080 $ do
  post "/init" $ do
    status ok200
  post "/run" $ do
    d <- jsonData
    json (d :: Value)
