{-# LANGUAGE TypeOperators #-}
{-# LANGUAGE DataKinds #-}

module User.Controller (
  userProxy
, userServer
) where

import Servant
import Control.Monad.Except
import Debug.Trace
import Database.PostgreSQL.Simple hiding (Query)
import Data.Int

import User.Model
import Club.Model
import User.Op

userProxy = Proxy :: Proxy UserAPI

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

userServer :: Server UserAPI
userServer = do
  getUsers
  :<|> getUser
  :<|> createUser
  :<|> deleteUser
  :<|> getMales
  :<|> getFemales
  :<|> getDetailedUser
  where
    getUsers           = liftOp User.Op.index
    createUser user    = trace (show user) liftOp $ User.Op.create user
    deleteUser id      = liftOp $ User.Op.delete id
    getUser id         = liftOp $ User.Op.find id
    getMales           = liftOp User.Op.males
    getFemales         = liftOp User.Op.females
    getDetailedUser id = liftOp $ User.Op.details id

liftOp op = liftIO op >>= return
