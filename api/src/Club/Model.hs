{-# LANGUAGE DeriveGeneric #-}

module Club.Model ( Club
                  , ClubColumn
                  , Club'(..)
                  ) where

import GHC.Generics
import Opaleye (Column, PGInt4, PGText)

data Club' a b = Club'
  { clbId :: a
  , clbName :: b
  } deriving (Eq, Show, Generic)

type Club = Club' Int String
type ClubColumn = Club' (Column PGInt4) (Column PGText)
