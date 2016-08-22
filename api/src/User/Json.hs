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
import Practitioner.Model
import GHC.Exts (fromList)
import Database.PostgreSQL.Simple.Types
import Data.Aeson.Compat
import Data.ByteString.Builder (byteString)

-- JSON MAPPER

instance ToJSON User
--instance ToJSON Gender
instance ToJSON Practitioner

instance ToJSON (User :. Practitioner) where
  toJSON (user :. practitioner) =
    Object $ fromList [ ("user",         toJSON user)
                      , ("practitioner", toJSON practitioner)
                      ]

instance ToRow User where
  toRow User'{..} =
    [ toField usrId
    , toField usrName
    , toField usrEmail
--    , toField gender
    ]
{-
instance ToField (Maybe Gender) where
  toField (Just Female) = Plain $ byteString "female"
  toField (Just Male)   = Plain $ byteString "male"
  toField _ = Plain $ byteString ""
-}

-- SQL MAPPER

instance FromRow Practitioner where
  fromRow = Practitioner <$> field

instance FromRow User where
  fromRow = User' <$> field <*> field <*> field-- <*> field

{-instance FromField (Maybe Gender) where
  fromField f mdata =
    return gender
    where gender = case mdata of
            Just "female" -> Just Female
            Just "male" -> Just Male
            _ -> Nothing
-}
