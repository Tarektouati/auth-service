{-# LANGUAGE DataKinds #-}
{-# LANGUAGE TypeOperators #-}
{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE DuplicateRecordFields #-}


module Handler 
          ( verify
          , generate
          ) where

import Token (decodeToken, createToken, verifyToken)
import Types (Generate(..),Verify(..),Response(..))
import Servant (Handler)
import Data.Text (Text)


verify :: Text -> Verify -> Handler Response
verify secret Verify{jwt=t} = do
  case (verifyToken secret $ t) of
    Nothing -> return $ Response "Token not verified" False Nothing Nothing
    Just x -> return $ 
                Response "Token verified" True (Just t) (Just user)
                where user = decodeToken x
       
generate :: Text -> Generate -> Handler Response
generate secret Generate{user = u} = do
  let token = createToken secret $ u
    in return $ Response "Token generated succefully" True (Just token) Nothing
