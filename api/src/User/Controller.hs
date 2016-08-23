{-# LANGUAGE TypeOperators #-}
{-# LANGUAGE DataKinds #-}

module User.Controller (
  userProxy
, userServer
) where

import Servant
import Control.Monad.Except

import User.Model
import User.Op
import Debug.Trace

userProxy = Proxy :: Proxy UserAPI

type UserAPI =
  "users" :> Get '[JSON] [User]
  :<|> "users" :> Capture "x" Int :> Get '[JSON] [User]
  :<|> "users.male" :> Get '[JSON] [User]

userServer :: Server UserAPI
userServer = do
  getUsers
  :<|> getUser
  :<|> getMales
  where
    getUsers = liftOp User.Op.index
    getUser id = liftOp $ User.Op.find id
    getMales = liftOp User.Op.males

liftOp op = liftIO op >>= return
