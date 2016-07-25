{-# LANGUAGE TypeOperators #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE OverloadedStrings #-}

module Mapping (
) where

import Database.PostgreSQL.Simple.FromField
import Database.PostgreSQL.Simple.FromRow
import User.Model
import Practitioner.Model
import GHC.Exts (fromList)
import Database.PostgreSQL.Simple.Types

import Data.Aeson.Compat

-- JSON MAPPER

instance ToJSON User
instance ToJSON Title
instance ToJSON Practitioner

instance ToJSON (User :. Practitioner) where
  toJSON (user :. practitioner) =
    Object $ fromList [ ("user",         toJSON user)
                      , ("practitioner", toJSON practitioner)
                      ]

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
