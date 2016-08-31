module User.Op (
  create
, details
, delete
, females
, find
, index
, males
) where

import Prelude hiding (show)
import User.Model
import Club.Model
import Club.Schema
import User.Schema
import qualified User.Query as QUsr
import qualified Club.Query as QClb
import Connection
import Data.Int

index :: IO [User]
index = do
  runGet QUsr.all

find :: Int -> IO [User]
find id = do
  runGet $ QUsr.find id

males :: IO [User]
males = do
  runGet $ QUsr.withGender Male

females :: IO [User]
females = do
  runGet $ QUsr.withGender Female

details :: Int -> IO ([User], [Club])
details id = do
  users <- find id
  clubs <- runGet $ QClb.with_users $ map usrId users
  return (users, clubs)

create :: User -> IO [User]
create newUser = return [ newUser ]

delete :: Int -> IO Int64
delete id = do
  runDel $ QUsr.delete id
