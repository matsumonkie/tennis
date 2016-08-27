{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE Arrows #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE FlexibleContexts #-}

module Club.Query (
  find
, with_users
) where

import Prelude hiding (all)
import Opaleye (Query, queryTable, showSqlForPostgres)
import Data.Profunctor.Product.TH (makeAdaptorAndInstance)
import Data.Profunctor.Product.Default (Default)

import Club.Model
import Club.Schema
import Control.Arrow (returnA, (<<<))
import Opaleye
import Data.Char hiding (all)

all :: Query ClubColumn
all = queryTable clubsTable

find :: Int -> Query ClubColumn
find id = proc () -> do
  row@(Club'{ clbId = id' }) <- all -< ()
  restrict -< id' .== pgInt4 id
  returnA -< row

with_users :: [Int] -> Query ClubColumn
with_users ids = proc () -> do
  row@(Club'{ clbId = id' }) <- all -< ()
  restrict -< id' .== pgInt4 (head ids)
  returnA -< row
