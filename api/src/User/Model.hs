{-# LANGUAGE DeriveGeneric #-}

module User.Model ( User(..)
                  , Gender(..)
                  ) where

import GHC.Generics

data User = User { userId :: Int
                 , email :: String
                 , name :: String
                 , gender :: Maybe Gender
                 } deriving (Eq, Show, Generic)

data Gender = Female | Male deriving (Eq, Show, Generic)
