{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE OverloadedStrings #-}

module Query (
  usersQuery
, userQuery
, usersWithPractitionersQuery
, changeUserNameQuery
) where

import Database.PostgreSQL.Simple.SqlQQ
import Database.PostgreSQL.Simple.Types
import Database.PostgreSQL.Simple (Query)
import Data.ByteString.Char8 (pack)
import GHC.Exts (fromList)
import Debug.Trace

practitionersQuery :: Query
practitionersQuery =
  [sql|
      SELECT prc.phone
      FROM practitioners AS prc
      LIMIT 4
      |]

changeUserNameQuery :: Int -> String -> Query
changeUserNameQuery id name =
  let
    rawQuery =
      "UPDATE users \
      \SET first_name = '" ++ name ++ "' \
      \WHERE id = " ++ (show id)
  in
    Query $ pack rawQuery

userQuery :: Int -> Query
userQuery id =
  let
    rawQuery =
      "SELECT usr.id, usr.first_name, usr.title \
      \FROM users AS usr \
      \WHERE usr.id = " ++ (show id) ++ " LIMIT 1"
  in
    Query $ pack rawQuery

findPractitionerQuery :: Query
findPractitionerQuery =
  [sql|
      SELECT prc.phone
      FROM practitioners AS prc
      WHERE prc.id = 1
      LIMIT 1
      |]

usersWithPractitionersQuery :: Query
usersWithPractitionersQuery =
  [sql|
      SELECT usr.id, usr.first_name, usr.title, prc.phone
      FROM users AS usr
      INNER JOIN practitioner_users AS pru ON usr.id = pru.user_id
      INNER JOIN practitioners      AS prc ON pru.practitioner_id = prc.id
      LIMIT 4
      |]

usersQuery :: Query
usersQuery =
  [sql|
      SELECT usr.id, usr.first_name, usr.title
      FROM users AS usr
      LIMIT 4
      |]
