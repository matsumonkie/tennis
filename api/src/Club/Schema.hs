{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE OverloadedStrings #-}

module Club.Schema ( ClubColumn
                   , clubsTable
                   ) where

import Data.Profunctor.Product.TH (makeAdaptorAndInstance)
import Club.Model
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

$(makeAdaptorAndInstance "pClub" ''Club')

clubsTable :: Table ClubColumn ClubColumn
clubsTable = Table "clubs"
  (pClub Club'
    { clbId   = required "id"
    , clbName = required "name"
    })
