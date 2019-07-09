{-# LANGUAGE DataKinds, DuplicateRecordFields, OverloadedStrings, TypeOperators #-}


module Handler
          ( verify
          , generate
          ) where

import           Data.Text (Text)
import           Servant (Handler, err500, errBody, throwError)
import           Token (createToken, decodeToken, verifyToken)
import           Types (Generate (..), Response (..), Verify (..))


verify :: Text -> Verify -> Handler Response
verify secret Verify{jwt=t} =
  case  verifyToken secret t of
    Nothing -> throwError $ err500 { errBody = "Token not verified" }
    Just x -> return $
                Response "Token verified" True (Just t) (Just userDecoded)
                where userDecoded = decodeToken x

generate :: Text -> Generate -> Handler Response
generate secret Generate{user = u} =
  return $ Response "Token generated succefully" True (Just tokenGenerated) Nothing
  where tokenGenerated = createToken secret u
