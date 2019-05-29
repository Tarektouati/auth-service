{-# LANGUAGE DataKinds #-}
{-# LANGUAGE TypeOperators #-}
{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE DuplicateRecordFields #-}


module Server
    ( webApp,
      toInt
    ) where

import Servant
        ( Server
        , Proxy(..)
        , Application
        , serve
        , (:<|>)(..)
        )
import Network.Wai.Handler.Warp(run)
import Data.Text (Text)
import Router (UserAPI)
import Handler (verify, generate)

--- Utils :: Turn String toInt
toInt :: String -> Int
toInt x = read x :: Int

server :: Text ->  Server UserAPI
server secret = verify secret :<|> generate secret

userAPI :: Proxy UserAPI
userAPI = Proxy

app :: Text -> Application
app secret = serve userAPI $ server secret

webApp :: Int -> Text -> IO ()
webApp port secret = run port $ app secret