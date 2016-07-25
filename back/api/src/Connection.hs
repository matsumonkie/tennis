{-# LANGUAGE OverloadedStrings #-}

module Connection (
  fetch
, exec
) where

import Control.Monad.Reader
import Database.PostgreSQL.Simple

fetch :: FromRow a => Query -> IO [a]
fetch q = do
  liftIO connection >>= (flip query_) q

exec :: Query -> IO Int
exec q =
  let q' = ((flip query_) q)
  in
    connection >>= q' >>= return

connection :: IO Connection
connection =
  connectPostgreSQL config
  where config = "dbname='medrefer_dev' \
                 \user='iori' \
                 \password='iori'"
