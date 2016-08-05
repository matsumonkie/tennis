{-# LANGUAGE TypeOperators #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RecordWildCards #-}

module Mapping (
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
instance ToJSON Title
instance ToJSON Practitioner

instance ToJSON (User :. Practitioner) where
  toJSON (user :. practitioner) =
    Object $ fromList [ ("user",         toJSON user)
                      , ("practitioner", toJSON practitioner)
                      ]

instance ToRow User where
  toRow User{..} =
    [ toField userId
    , toField name
    , toField title
    ]

instance ToField Title where
  toField Ms      = Plain $ byteString "ms"
  toField Prof    = Plain $ byteString "prof"
  toField Mr      = Plain $ byteString "mr"
  toField Dr      = Plain $ byteString "dr"
  toField NoTitle = Plain $ byteString ""


-- SQL MAPPER

instance FromRow Practitioner where
  fromRow = Practitioner <$> field

instance FromRow User where
  fromRow = User <$> field <*> field <*> field

instance FromField Title where
  fromField f mdata =
    return title
    where title = case mdata of
            Just "Ms" -> Ms
            Just "Mr" -> Mr
            Just "Dr" -> Dr
            Just "Prof" -> Prof
            _ -> NoTitle
