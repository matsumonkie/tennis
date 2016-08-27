{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE DeriveGeneric #-}

module Connection (
  exec
) where

import Control.Monad.Reader
import Data.Int
import Database.PostgreSQL.Simple.ToField
import Data.ByteString.Builder (byteString)
import Opaleye (runQuery)
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

exec :: D.Default QueryRunner a b => Query a -> IO [b]
exec query = do
  co <- connection
  runQuery co query
