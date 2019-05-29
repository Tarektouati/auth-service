{-# LANGUAGE DataKinds #-}
{-# LANGUAGE TypeOperators #-}
{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE DuplicateRecordFields #-}

module Token 
    ( createToken,
      verifyToken,
      decodeToken,
      toClaimsMap,
      toUser
    ) where


import Data.Aeson (ToJSON, FromJSON, Value(..))
import GHC.Generics(Generic)
import Data.Maybe (fromMaybe)
import Web.JWT as JWT
import Data.Text (Text, pack)
import Data.Map.Strict as Map
import Data.Time.Clock as Time (nominalDay)
import Types (User(..))


-- Create JWT Token 
createToken :: Text -> User -> Text
createToken secret user = 
  let cs = mempty {
      iss = JWT.stringOrURI $ "authservice",
      JWT.exp = JWT.numericDate $ Time.nominalDay,
      unregisteredClaims = toClaimsMap $ Map.fromList $ mapUser $ user
    }
      key = JWT.hmacSecret secret
  in JWT.encodeSigned key mempty cs



verifyToken :: Text -> Text -> Maybe (JWT VerifiedJWT)
verifyToken secret token = 
  JWT.verify (hmacSecret secret) =<< JWT.decode token

decodeToken :: JWT VerifiedJWT -> User
decodeToken jwt = 
    let cs = JWT.claims jwt
        ucs = unregisteredClaims cs 
        in toUser $ assocs $ unClaimsMap ucs 


toClaimsMap :: Map Text Value -> JWT.ClaimsMap
toClaimsMap x = JWT.ClaimsMap x


mapUser:: User -> [(Text, Value)]
mapUser User{email=e,id=i,firstName=f,lastName=l} = 
  [(pack $ "email", String $ e), (pack $ "firstName", String $ f), (pack $ "id", String $ i), (pack $ "lastName", String $ l)]

-- User Constructor
toUser :: [(Text, Value)] -> User
toUser xs = User{email=e,id=i,firstName=f,lastName=l}
  where  m = Map.fromList xs
         find name = fromMaybe "" $ Map.lookup name m
         (String e) = find "email"
         (String f) = find "firstName"
         (String l) = find "lastName"
         (String i) = find "id"