{-# LANGUAGE TypeOperators #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE OverlappingInstances #-}

module User.Json (
) where

import Database.PostgreSQL.Simple.FromField
import Database.PostgreSQL.Simple.FromRow
import Database.PostgreSQL.Simple.ToRow
import Database.PostgreSQL.Simple.ToField
import User.Model
import Club.Model
import Club.Json
import GHC.Exts (fromList)
import Database.PostgreSQL.Simple.Types
import Data.Aeson.Compat
import Data.ByteString.Builder (byteString)

-- JSON MAPPER

instance ToJSON User
instance ToJSON Gender

instance FromJSON User where
  parseJSON = withObject "user" $ \o -> do
    usrEmail <- o .: "email"
    usrName <- o .: "name"
    usrGender <- o .: "gender"
    let usrId = 1
    return User'{..}

instance FromJSON Gender where
  parseJSON = withText "gender" (\x -> return Female)

instance ToJSON (User :. Club) where
  toJSON (user :. club) =
    Object $ fromList [ ("user", toJSON user)
                      , ("club", toJSON club)
                      ]
