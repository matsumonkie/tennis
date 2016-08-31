{-# LANGUAGE DeriveGeneric #-}

module User.Model ( User
                  , RUserColumn
                  , WUserColumn
                  , User'(..)
                  , Gender(..)
                  ) where

import GHC.Generics
import Opaleye (Column, PGInt4, PGText, Nullable)

data User' a b c d = User'
  { usrId     :: a
  , usrEmail  :: b
  , usrName   :: c
  , usrGender :: d
  } deriving (Eq, Show, Generic)

type User = User' Int String String (Gender)
type UserColumn a = User' a (Column PGText) (Column PGText) (Column PGText)
type RUserColumn = UserColumn (Column PGInt4)
type WUserColumn = UserColumn (Maybe (Column PGInt4))

data Gender = Female | Male deriving (Eq, Show, Generic)
