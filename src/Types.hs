{-# LANGUAGE DataKinds, DeriveGeneric, DuplicateRecordFields, OverloadedStrings, TypeOperators #-}


module Types
        ( User(..)
        , Verify(..)
        , Generate(..)
        , Response(..)
        ) where

import           Data.Aeson (FromJSON, ToJSON)
import           Data.Text (Text)
import           GHC.Generics (Generic)

data User = User {
    email     :: Text,
    id        :: Text,
    firstName :: Text,
    lastName  :: Text
  } deriving (Eq, Show, Generic)

instance ToJSON User
instance FromJSON User

newtype Verify = Verify{
  jwt :: Text
} deriving (Eq, Show, Generic)

instance ToJSON Verify
instance FromJSON Verify


newtype Generate = Generate{
  user :: User
} deriving (Eq, Show, Generic)

instance ToJSON Generate
instance FromJSON Generate


data Response = Response {
    message :: Text,
    success :: Bool,
    token   :: Maybe Text,
    user    :: Maybe User
  } deriving (Eq, Show, Generic)

instance ToJSON Response
instance FromJSON Response
