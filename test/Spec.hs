{-# LANGUAGE DataKinds, DuplicateRecordFields, OverloadedStrings, TypeOperators #-}

import           Control.Exception (evaluate)
import           Control.Monad.IO.Class (liftIO)
import           Data.Text (Text)
import           Servant (Handler (..), ServantErr (..), runHandler)
import           Test.Hspec

import           Handler (generate, verify)
import           SampleData
    ( failResponse
    , generateResponse
    , sampleFailVerify
    , sampleGenerate
    , sampleToken
    , sampleUser
    , sampleVerify
    , verifyResponse
    )

import           Token (createToken, decodeToken, verifyToken)
import           Types (Generate (..), Response (..), User (..), Verify (..))





main :: IO ()
main = hspec $
  describe "Token Module" $ do
    it "returns a generated JWT token based on given user" $
      createToken "super-secret-secret-key" sampleUser `shouldBe` (sampleToken :: Text)

    it "return a user based on given JWT token" $
      case verifyToken "super-secret-secret-key" sampleToken of
        Nothing -> sampleUser `shouldBe` (sampleUser:: User)
        Just t  -> decodeToken t  `shouldBe` (sampleUser:: User)

    it "return response with verified JWT" $
      runHandler(verify "super-secret-secret-key" sampleVerify)`shouldReturn` (verifyResponse :: Either ServantErr Response)

    it "return response with generated JWT" $
      runHandler(generate "super-secret-secret-key" sampleGenerate)`shouldReturn` (generateResponse :: Either ServantErr Response)

    it "return servant error" $
      runHandler(verify "super-secret-secret-key" sampleFailVerify) `shouldReturn` (failResponse :: Either ServantErr Response)

