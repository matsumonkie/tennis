module User.Op (
  index
, find
, males
, changeName
) where

import Prelude hiding (show)
import User.Model
import User.Predicate
import qualified User.Query as Query
import User.Json
import User.Table
import Connection
import Data.Int
import Opaleye (runQuery, Query)

import qualified Database.PostgreSQL.Simple as PGS

index :: IO [User]
index = do
   co <- connection
   runQuery2 co Query.users

runQuery2 :: PGS.Connection -> Query UserColumn -> IO [User]
runQuery2 = runQuery

find :: Int -> IO [User]
find id = do
  co <- connection
  runQuery2 co $ Query.find id

males :: IO [User]
males = undefined
{-  fmap (filter isMale) index -}

changeName :: Int -> String -> IO User
changeName id newName = undefined {-do
  users <- find id
  let user = head users
  let newUser = user { name = newName }
  exec changeUserNameQuery2 (name newUser, userId newUser)
  return newUser
-}
