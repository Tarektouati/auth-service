{-# LANGUAGE OverloadedStrings #-}

module Main where

import Server (webApp,toInt)
import System.Environment (lookupEnv)
import Data.Maybe  (fromMaybe)
import Data.Text (pack)


main :: IO ()
main = do 
  maybePort <- lookupEnv "PORT"
  maybeSecret <- lookupEnv "SECRET_KEY"
  let port = fromMaybe "4002" maybePort
      secret = fromMaybe "super-secret-secret-key" maybeSecret
    in webApp (toInt port) (pack secret)