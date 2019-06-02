{-# LANGUAGE DataKinds, DuplicateRecordFields, OverloadedStrings, TypeOperators #-}

module Token
    ( createToken,
      verifyToken,
      decodeToken,
      toClaimsMap,
      toUser
    ) where


import           Data.Aeson (FromJSON, ToJSON, Value (..))
import           Data.Map.Strict as Map
import           Data.Maybe (fromMaybe)
import           Data.Text (Text, pack)
import           Data.Time.Clock as Time (nominalDay)
import           GHC.Generics (Generic)
import           Types (User (..))
import           Web.JWT as JWT


-- Create JWT Token
createToken :: Text -> User -> Text
createToken secret user =
  let cs = mempty {
      iss = JWT.stringOrURI "authservice",
      JWT.exp = JWT.numericDate Time.nominalDay,
      unregisteredClaims = toClaimsMap $ Map.fromList $ mapUser user
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
toClaimsMap = JWT.ClaimsMap


mapUser:: User -> [(Text, Value)]
mapUser User{email=e,id=i,firstName=f,lastName=l} =
  [(pack "email", String e), (pack "firstName", String f), (pack "id", String i), (pack "lastName", String l)]

-- User Constructor
toUser :: [(Text, Value)] -> User
toUser xs = User{email=e,id=i,firstName=f,lastName=l}
  where  m = Map.fromList xs
         find name = fromMaybe "" $ Map.lookup name m
         (String e) = find "email"
         (String f) = find "firstName"
         (String l) = find "lastName"
         (String i) = find "id"
