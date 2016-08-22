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
  :<|> "changeName" :> Capture "x" Int :> Capture "name" String :> Get '[JSON] User

userServer :: Server UserAPI
userServer = do
  getUsers
  :<|> getUser
  :<|> getMales
  :<|> changeName
  where
    getUsers = liftOp User.Op.index
    getUser id = liftOp $ User.Op.find id
    getMales = liftOp User.Op.males
    changeName id name = liftOp $ User.Op.changeName id name

liftOp op = liftIO op >>= return
