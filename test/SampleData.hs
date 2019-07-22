{-# LANGUAGE DataKinds, DuplicateRecordFields, OverloadedStrings, TypeOperators #-}

module SampleData (sampleVerify,sampleGenerate, generateResponse, verifyResponse, sampleUser, sampleToken, sampleFailVerify, sampleFailToken, failResponse) where

import           Data.Text (Text)
import           Servant (Handler (..), ServantErr (..), err500, errBody, throwError)

import           Types (Generate (..), Response (..), User (..), Verify (..))

sampleVerify :: Verify
sampleVerify = Verify{jwt = sampleToken}

sampleFailVerify :: Verify
sampleFailVerify = Verify{jwt = sampleFailToken}

sampleGenerate :: Generate
sampleGenerate = Generate{user = sampleUser}


generateResponse :: Either ServantErr Response
generateResponse =
  return response
  where response = Response "Token generated succefully" True (Just sampleToken) Nothing

failResponse :: Either ServantErr Response
failResponse = throwError $ err500 { errBody = "Token not verified" }


verifyResponse :: Either ServantErr Response
verifyResponse =
  return response
  where response = Response "Token verified" True (Just sampleToken) (Just sampleUser)

sampleUser :: User
sampleUser = User{email = "test3@test.com", id= "1234", firstName ="test1", lastName ="test2"}

sampleToken :: Text
sampleToken = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6InRlc3QzQHRlc3QuY29tIiwiZXhwIjo4NjQwMCwibGFzdE5hbWUiOiJ0ZXN0MiIsImlzcyI6ImF1dGhzZXJ2aWNlIiwiZmlyc3ROYW1lIjoidGVzdDEiLCJpZCI6IjEyMzQifQ.7iETQcWJbHaduIRzA4aCKt26o8mhmfXL9EnoGMQZhuc"

sampleFailToken :: Text
sampleFailToken = "eyJlbWFpbCI6InRlc3Q0QHRlc3QuY29tIiwiZXhwIjo4NjQwMCwibGFzdE5hbWUiOiJ0ZXN0MiIsImlzcyI6ImF1dGhzZXJ2aWNlIiwiZmlyc3ROYW1lIjoidGVzdDEiLCJpZCI6IjEyMzQifQ.HqOf53UM8rkgxnkdobTGI630IKZD5Scd-bGw0FxiyRc"
