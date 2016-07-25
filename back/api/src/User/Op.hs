module User.Op (
  index
, show
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

index :: IO [User]
index = fetch usersQuery

show :: Int -> IO [User]
show id = fetch $ userQuery id

males :: IO [User]
males =
  fmap (filter isMale) index

females :: IO [User]
females =
  fmap (filter isFemale) index

changeName :: Int -> String -> IO Int
changeName id newName =
  exec $ changeUserNameQuery id newName
