{-# LANGUAGE DataKinds #-}
{-# LANGUAGE TypeOperators #-}
{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE DuplicateRecordFields #-}


module Router 
      ( UserAPI
      ) where

import Servant (ReqBody, Post, JSON, (:>), (:<|>))
import Types

type UserAPI = "verify" :> ReqBody '[JSON] Verify :> Post '[JSON] Response
          :<|> "generate" :> ReqBody '[JSON] Generate :> Post '[JSON] Response