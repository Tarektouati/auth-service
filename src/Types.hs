{-# LANGUAGE DataKinds #-}
{-# LANGUAGE TypeOperators #-}
{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE DuplicateRecordFields #-}


module Types 
        ( User(..)
        , Verify(..)
        , Generate(..)
        , Response(..)
        ) where

import Data.Aeson (ToJSON, FromJSON)
import Data.Text (Text)
import GHC.Generics(Generic)

data User = User { 
    email :: Text,
    id :: Text,
    firstName :: Text,
    lastName:: Text
  } deriving (Eq, Show, Generic)

instance ToJSON User
instance FromJSON User

data Verify = Verify{ 
  jwt :: Text
} deriving (Eq, Show, Generic)

instance ToJSON Verify
instance FromJSON Verify


data Generate = Generate{ 
  user :: User
} deriving (Eq, Show, Generic)

instance ToJSON Generate
instance FromJSON Generate


data Response = Response { 
    message :: Text,
    success :: Bool,
    token :: Maybe Text,
    user :: Maybe User
  } deriving (Eq, Show, Generic)

instance ToJSON Response
instance FromJSON Response