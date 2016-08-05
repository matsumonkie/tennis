{-# LANGUAGE DeriveGeneric #-}

module Practitioner.Model (
  Practitioner(..)
) where

import GHC.Generics

data Practitioner = Practitioner { phone :: String
                                 } deriving (Eq, Show, Generic)
