{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE DeriveGeneric #-}

module Connection (
  fetch
, fetch2
, exec
, connection
) where

import Control.Monad.Reader
import Database.PostgreSQL.Simple
import Data.Int
import Database.PostgreSQL.Simple.ToField
import Data.ByteString.Builder (byteString)
import Opaleye (runQuery)

fetch :: FromRow a => Query -> IO [a]
fetch q = do
  liftIO connection >>= (flip query_) q

--fetch2 :: Query a -> IO [b]
fetch2 q = undefined
--  runQuer connection

connection :: IO Connection
connection =
  connectPostgreSQL config
  where config = "dbname='tennis_dev' \
                 \user='iori' \
                 \password='iori'"

exec :: ToRow a => Query -> a -> IO Int64
exec query values = do
  co <- connection
  execute co query values
