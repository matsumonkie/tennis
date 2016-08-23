{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE Arrows #-}
{-# LANGUAGE OverloadedStrings #-}

module User.Query (
  all
, find
, withGender
) where

import Prelude hiding (all)
import Opaleye (Query, queryTable)
import Data.Profunctor.Product.TH (makeAdaptorAndInstance)

import User.Model
import User.Table
import Control.Arrow (returnA, (<<<))
import Opaleye
import Data.Char hiding (all)

all :: Query UserColumn
all = queryTable usersTable

find :: Int -> Query UserColumn
find id = proc () -> do
  users@(User'{ usrId = id' }) <- all -< ()
  restrict -< id' .== pgInt4 id
  returnA -< users

withGender :: Gender -> Query UserColumn
withGender gender = proc () -> do
  users@(User'{ usrGender = gender' }) <- all -< ()
  restrict -< gender' .== (pgString $ map toLower $ show gender)
  returnA -< users
