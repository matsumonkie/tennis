{-# LANGUAGE TypeOperators #-}
{-# LANGUAGE DataKinds #-}

module User.Route (
  UserAPI
) where

import Servant
import Data.Int

import User.Model
import Club.Model

type UserAPI =
  "users"
    :> Get '[JSON] [User]

  :<|> "users"
    :> Capture "id" Int :> Get '[JSON] [User]

  :<|> "users"
    :> ReqBody '[JSON] User :> Post '[JSON] [User]

  :<|> "users"
    :> Capture "id" Int :> Delete '[JSON] Int64

  :<|> "users.male"
    :> Get '[JSON] [User]

  :<|> "users.female"
    :> Get '[JSON] [User]

  :<|> "users.detailed"
    :> Capture "id" Int :> Get '[JSON] ([User], [Club])
