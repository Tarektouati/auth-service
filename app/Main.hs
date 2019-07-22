{-# LANGUAGE OverloadedStrings #-}

module Main where

import           Data.Maybe (fromMaybe)
import           Data.Text (pack)
import           Server (toInt, webApp)
import           System.Environment (lookupEnv)


main :: IO ()
main = do
  maybePort <- lookupEnv "PORT"
  maybeSecret <- lookupEnv "SECRET_KEY"
  let port = toInt $ fromMaybe "4002" maybePort
      secret = pack $ fromMaybe "super-secret-secret-key" maybeSecret
    in webApp port secret
