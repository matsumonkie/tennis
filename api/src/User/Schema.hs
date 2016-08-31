{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE TemplateHaskell #-}

module User.Schema ( usersTable
                   ) where

import Data.Profunctor.Product.TH (makeAdaptorAndInstance)
import User.Model
import Opaleye.PGTypes
import Database.PostgreSQL.Simple.FromField
import Opaleye

$(makeAdaptorAndInstance "pUser" ''User')

usersTable :: Table WUserColumn RUserColumn
usersTable = Table "users"
  (pUser User'
    { usrId     = optional "id"
    , usrEmail  = required "email"
    , usrName   = required "name"
    , usrGender = required "gender"
    })

instance FromField (Gender) where
  fromField f mdata =
    return gender
    where
      gender = case mdata of
        Just "female" -> Female
        Just "male" -> Male
        _ -> Male

instance QueryRunnerColumnDefault PGText Gender where
  queryRunnerColumnDefault = fieldQueryRunnerColumn
