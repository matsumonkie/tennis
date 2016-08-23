{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE Arrows #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE FlexibleContexts #-}

module User.Query (
  all
, find
, withGender
) where

import Prelude hiding (all)
import Opaleye (Query, queryTable, showSqlForPostgres)
import Data.Profunctor.Product.TH (makeAdaptorAndInstance)
import Data.Profunctor.Product.Default (Default)

import User.Model
import User.Table
import Control.Arrow (returnA, (<<<))
import Opaleye
import Data.Char hiding (all)

all :: Query UserColumn
all = queryTable usersTable

find :: Int -> Query UserColumn
find id = proc () -> do
  row@(User'{ usrId = id' }) <- all -< ()
  restrictId id -< id'
  returnA -< row

withGender :: Gender -> Query UserColumn
withGender gender = proc () -> do
  row@(User' { usrGender = gender' }) <- all -< ()
  restrictGender gender -< gender'

  returnA -< row

restrictGender :: Gender -> QueryArr (Column PGText) ()
restrictGender gender' = proc gender -> do
  restrict -< gender .== (pgString $ map toLower $ show gender')

restrictId :: Int -> QueryArr (Column PGInt4) ()
restrictId id' = proc id -> do
  restrict -< id .== pgInt4 id'
