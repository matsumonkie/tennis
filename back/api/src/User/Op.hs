module User.Op (
  index
, find
, males
, females
, changeName
) where

import Prelude hiding (show)
import User.Model
import User.Predicate
import Connection
import Mapping
import Query
import Data.Int

index :: IO [User]
index = fetch usersQuery

find :: Int -> IO [User]
find id = fetch $ userQuery id

males :: IO [User]
males =
  fmap (filter isMale) index

females :: IO [User]
females =
  fmap (filter isFemale) index

changeName :: Int -> String -> IO User
changeName id newName = do
  users <- find id
  let user = head users
  let newUser = user { name = newName }
  exec changeUserNameQuery2 (name newUser, userId newUser)
  return newUser
