{-# LANGUAGE TypeOperators #-}

module User.Op (
  index
, find
, males
, females
, details
) where

import Prelude hiding (show)
import User.Model
import Club.Model
import Club.Schema
import qualified User.Query as QUsr
import qualified Club.Query as QClb
import User.Json
import User.Schema
import Connection
import Data.Int
import Opaleye (runQuery, Query)
import Opaleye.Internal.RunQuery as F
import Database.PostgreSQL.Simple hiding (Query)

import qualified Database.PostgreSQL.Simple as PGS

index :: IO [User]
index = do
  exec QUsr.all

find :: Int -> IO [User]
find id = do
  exec $ QUsr.find id

males :: IO [User]
males = do
  exec $ QUsr.withGender Male

females :: IO [User]
females = do
  exec $ QUsr.withGender Female

details :: Int -> IO ([User], [Club])
details id = do
  users <- find id
  clubs <- exec $ QClb.with_users $ map usrId users
  return (users, clubs)
