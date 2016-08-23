module User.Op (
  index
, find
, males
) where

import Prelude hiding (show)
import User.Model
import qualified User.Query as QUsr
import User.Json
import User.Table
import Connection
import Data.Int
import Opaleye (runQuery, Query)
import Opaleye.Internal.RunQuery as F

import qualified Database.PostgreSQL.Simple as PGS

runQuery2 :: PGS.Connection -> Query UserColumn -> IO [User]
runQuery2 = runQuery

index :: IO [User]
index = do
   co <- connection
   runQuery2 co QUsr.all

find :: Int -> IO [User]
find id = do
  co <- connection
  runQuery2 co $ QUsr.find id

males :: IO [User]
males = do
  co <- connection
  runQuery2 co $ QUsr.withGender Male
