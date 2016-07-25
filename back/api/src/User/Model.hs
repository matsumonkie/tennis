{-# LANGUAGE DeriveGeneric #-}

module User.Model ( User(..)
                  , Title(..)
                  ) where

import GHC.Generics

data User = User { userId :: Int
                 , name :: String
                 , title :: Title
                 } deriving (Eq, Show, Generic)

data Title = Ms
           | Prof
           | Mr
           | Dr
           | NoTitle deriving (Eq, Show, Generic)
