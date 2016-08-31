{-# LANGUAGE Arrows #-}

module User.Query (
  all
, find
, withGender
, delete
) where

import Prelude hiding (all)
import Opaleye
import Data.Profunctor.Product.TH (makeAdaptorAndInstance)
import Data.Profunctor.Product.Default (Default)

import User.Model
import User.Schema
import Control.Arrow
import Opaleye
import Opaleye.Order
import Data.Char hiding (all)

all :: Query RUserColumn
all = queryTable usersTable

find :: Int -> Query RUserColumn
find id =
  limit 1 $ query
  where
    query = proc () -> do
      row@(User'{ usrId = id' }) <- all -< ()
      restrictId id -< id'
      returnA -< row

delete :: Int -> (Table WUserColumn RUserColumn, RUserColumn -> Column PGBool)
delete id =
  (usersTable, cond)
  where
    cond :: RUserColumn -> Column PGBool
    cond (User' { usrId = id' }) = pgInt4 id .== id'

withGender :: Gender -> Query RUserColumn
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
