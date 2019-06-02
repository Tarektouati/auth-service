{-# LANGUAGE DataKinds, DuplicateRecordFields, OverloadedStrings, TypeOperators #-}


module Router
      ( UserAPI
      ) where

import           Servant ((:<|>), (:>), JSON, Post, ReqBody)
import           Types

type UserAPI = "verify" :> ReqBody '[JSON] Verify :> Post '[JSON] Response
          :<|> "generate" :> ReqBody '[JSON] Generate :> Post '[JSON] Response
