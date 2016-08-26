module User.Op (
  index
, find
, males
, females
, more
) where

import Prelude hiding (show)
import User.Model
import qualified User.Query as QUsr
import User.Json
import User.Schema
import Connection
import Data.Int
import Opaleye (runQuery, Query)
import Opaleye.Internal.RunQuery as F

import qualified Database.PostgreSQL.Simple as PGS

runQuery2 :: PGS.Connection -> Query UserColumn -> IO [User]
runQuery2 = runQuery

ex :: Query UserColumn -> IO [User]
ex query = do
  co <- connection
  runQuery2 co query

index :: IO [User]
index = do
  ex QUsr.all

find :: Int -> IO [User]
find id = do
  ex $ QUsr.find id

more :: Int -> IO [User]
more id = do
  ex $ QUsr.find id

males :: IO [User]
males = do
  ex $ QUsr.withGender Male

females :: IO [User]
females = do
  ex $ QUsr.withGender Female
