{-# LANGUAGE DataKinds, DuplicateRecordFields, OverloadedStrings, TypeOperators #-}


module Handler
          ( verify
          , generate
          ) where

import           Data.Text (Text)
import           Servant (Handler)
import           Token (createToken, decodeToken, verifyToken)
import           Types (Generate (..), Response (..), Verify (..))


verify :: Text -> Verify -> Handler Response
verify secret Verify{jwt=t} =
  case  verifyToken secret t of
    Nothing -> return $ Response "Token not verified" False Nothing Nothing
    Just x -> return $
                Response "Token verified" True (Just t) (Just user)
                where user = decodeToken x

generate :: Text -> Generate -> Handler Response
generate secret Generate{user = u} =
  return $ Response "Token generated succefully" True (Just token) Nothing
  where token = createToken secret u
