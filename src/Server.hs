{-# LANGUAGE DataKinds, DuplicateRecordFields, OverloadedStrings, TypeOperators #-}


module Server
    ( webApp,
      toInt
    ) where

import           Data.Text (Text)
import           Handler (generate, verify)
import           Network.Wai.Handler.Warp (run)
import           Router (UserAPI)
import           Servant ((:<|>) (..), Application, Proxy (..), Server, serve)

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
