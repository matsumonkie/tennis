{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE DeriveGeneric #-}

module Connection (
  runDel
, runGet
) where

import Control.Monad.Reader
import Data.Int
import Database.PostgreSQL.Simple.ToField
import Data.ByteString.Builder (byteString)
import Opaleye
import qualified Data.Profunctor.Product.Default as D
import Database.PostgreSQL.Simple hiding (Query)
import Opaleye (runQuery, Query)
import Opaleye.Internal.RunQuery as F

connection :: IO Connection
connection =
  connectPostgreSQL config
  where config = "dbname='tennis_dev' \
                 \user='iori' \
                 \password='iori'"

runGet :: D.Default QueryRunner a b => Query a -> IO [b]
runGet query = do
  co <- connection
  runQuery co query

runDel :: (Table a b, b -> Column PGBool) -> IO Int64
runDel (table, condition) = do
  co <- connection
  res <- runDelete co table condition
  return res
