{-# LANGUAGE DataKinds, DuplicateRecordFields, OverloadedStrings, TypeOperators #-}


module Server
    ( webApp,
      toInt
    ) where

import           Data.Text (Text)
import           Handler (generate, verify)
import           Network.Wai.Handler.Warp (defaultSettings, runSettings, setLogger, setPort)
import           Network.Wai.Logger (withStdoutLogger)
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
webApp port secret = withStdoutLogger $ \applogger -> do
  let settings = setPort port $ setLogger applogger defaultSettings
  runSettings settings $ app secret



