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
--  :<|> "males" :> Get '[JSON] [User]
--  :<|> "females" :> Get '[JSON] [User]
  :<|> "user" :> Capture "x" Int :> Get '[JSON] [User]
  :<|> "changeName" :> Capture "x" Int :> Capture "name" String :> Get '[JSON] User

userServer :: Server UserAPI
userServer = do
  getUsers
--  :<|> getMales
--  :<|> getFemales
  :<|> getUser
  :<|> changeName
  where
    getUsers = liftOp User.Op.index
--    getMales = liftOp User.Op.males
--    getFemales = liftOp User.Op.females
    getUser id = liftOp $ User.Op.find id
    changeName id name = liftOp $ User.Op.changeName id name

liftOp op = liftIO op >>= return
