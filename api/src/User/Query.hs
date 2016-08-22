{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE Arrows #-}

module User.Query (
  users
, find
) where


import Opaleye (Query, queryTable)
import Data.Profunctor.Product.TH (makeAdaptorAndInstance)

import User.Model
import User.Table
import Control.Arrow (returnA, (<<<))
import Opaleye

users :: Query UserColumn
users = queryTable usersTable

find :: Int -> Query UserColumn
find id = proc () -> do
  all@(User'{ usrId = id' }) <- users -< ()
  restrict -< id' .== pgInt4 id
  returnA -< all
