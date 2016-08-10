{-# LANGUAGE OverloadedStrings #-}

module Network.OpenWhisk
  ( openwhiskWrapper )
  where

import           Data.Aeson hiding (json)
import           Data.Aeson.Types (parseMaybe)
import           Data.Maybe (fromMaybe)
import           Data.Text (Text)
import           Control.Monad.IO.Class (liftIO)
import           Network.HTTP.Types.Status
import           Web.Scotty

toServiceArgs :: Value -> Value
toServiceArgs = fromMaybe (object []) . (parseMaybe parser)
  where
    parser = withObject "jsonData" (.: "value")

openwhiskWrapper :: (Value -> IO (Maybe Value)) -> IO ()
openwhiskWrapper service = scotty 8080 $ do
  post "/init" $ do
    status ok200
  post "/run" $ do
    args <- fmap toServiceArgs jsonData
    result <- fromMaybe (object [])
              <$> liftIO (service args)
    case result of
      (Object o) -> do
        json o
        status ok200
      _ -> do
        let errMsg = "result is not an object" :: Text
        json (object ["error" .= errMsg])
        status status502
