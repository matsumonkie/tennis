{-# LANGUAGE TypeOperators #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE OverlappingInstances #-}

module Club.Json (
) where

import Database.PostgreSQL.Simple.FromField
import Database.PostgreSQL.Simple.FromRow
import Database.PostgreSQL.Simple.ToRow
import Database.PostgreSQL.Simple.ToField
import Club.Model
import GHC.Exts (fromList)
import Database.PostgreSQL.Simple.Types
import Data.Aeson.Compat
import Data.ByteString.Builder (byteString)

-- JSON MAPPER

instance ToJSON Club
