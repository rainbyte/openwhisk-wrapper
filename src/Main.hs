{-# LANGUAGE OverloadedStrings #-}

module Main where

import           Data.Aeson hiding (json)
import           Data.Aeson.Types (parseMaybe)
import           Data.Maybe (fromMaybe)
import           Data.Text (Text)
import           Network.HTTP.Types.Status
import           Web.Scotty

toServiceArgs :: Value -> Value
toServiceArgs = fromMaybe (object []) . (parseMaybe parser)
  where
    parser = withObject "jsonData" (.: "value")

openwhiskWrapper :: (Value -> Value) -> IO ()
openwhiskWrapper service = scotty 8080 $ do
  post "/init" $ do
    status ok200
  post "/run" $ do
    d <- jsonData
    let args = toServiceArgs d
        result = service args
    case result of
      (Object o) -> do
        json o
        status ok200
      _ -> do
        let errMsg = "result is not an object" :: Text
        json (object ["error" .= errMsg])
        status status502

main :: IO ()
main = openwhiskWrapper id
