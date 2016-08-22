{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE TemplateHaskell #-}

module User.Table ( UserColumn
                  , usersTable
                  ) where

import Data.Profunctor.Product.TH (makeAdaptorAndInstance)
import User.Model
import Data.Profunctor.Product (p2, p3, p4)
import Opaleye (Column,
                PGInt4,
                PGInt8,
                PGText,
                Column,
                Nullable,
                matchNullable,
                isNull,
                Table(Table), required, queryTable,
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
    })
