{-# LANGUAGE FlexibleInstances #-}

module Club.Json (
) where

import Club.Model
import Data.Aeson.Compat

instance ToJSON Club
