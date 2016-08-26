{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE OverloadedStrings #-}

module User.Schema ( UserColumn
                  , usersTable
                  ) where

import Data.Profunctor.Product.TH (makeAdaptorAndInstance)
import User.Model
import Data.Profunctor.Product (p2, p3, p4)
import Data.Set
import Opaleye.PGTypes
import Database.PostgreSQL.Simple.FromField
import Opaleye.Internal.RunQuery as F
import Opaleye (Column,
                PGInt4,
                PGInt8,
                PGText,
                Column,
                Nullable,
                matchNullable,
                isNull,
                Table(Table), required, optional, queryTable,
                Query, QueryArr, restrict, (.==), (.<=), (.&&), (.<),
                (.===),
                (.++), ifThenElse, pgString, aggregate, groupBy,
                count, avg, sum, leftJoin, runQuery,
                showSqlForPostgres, Unpackspec,
                PGInt4, PGInt8, PGText, PGDate, PGFloat8, PGBool)

$(makeAdaptorAndInstance "pUser" ''User')

usersTable :: Table UserColumn UserColumn
usersTable = Table "users"
  (pUser User'
    { usrId = required "id"
    , usrEmail = required "email"
    , usrName = required "name"
    , usrGender = required "gender"
    })

instance FromField (Gender) where
  fromField f mdata =
    return gender
    where
      gender = case mdata of
        Just "female" -> Female
        Just "male" -> Male
        _ -> Male

instance QueryRunnerColumnDefault PGText Gender where
  queryRunnerColumnDefault = fieldQueryRunnerColumn
