{-# LANGUAGE TypeOperators #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RecordWildCards #-}

module User.Json (
) where

import User.Model
import Club.Model
import Data.Aeson.Compat

instance ToJSON User
instance ToJSON Gender

instance FromJSON User where
  parseJSON = withObject "user" $ \o -> do
    usrEmail <- o .: "email"
    usrName <- o .: "name"
    usrGender <- o .: "gender"
    let usrId = 1
    return User'{..}

instance FromJSON Gender where
  parseJSON = withText "gender" (\x -> return Female)
