{-# LANGUAGE DeriveGeneric #-}

module User.Model ( User
                  , UserColumn
                  , User'(..)
--                  , Gender(..)
                  ) where

import GHC.Generics
import Opaleye (Column,
                PGInt4,
                PGInt8,
                PGText)

data User' a b c = User'
  { usrId :: a
  , usrEmail :: b
  , usrName :: c
--  , gender :: d
  } deriving (Eq, Show, Generic)

type User = User' Int String String --(Maybe Gender)
type UserColumn = User' (Column PGInt4) (Column PGText) (Column PGText)

--data Gender = Female | Male deriving (Eq, Show, Generic)
