{-# LANGUAGE TypeOperators #-}
{-# LANGUAGE DataKinds #-}

module User.Controller (
  userProxy
, userServer
) where

import Servant
import Control.Monad.Except

import User.Model
import Club.Model
import User.Op
import Debug.Trace
import Database.PostgreSQL.Simple hiding (Query)

userProxy = Proxy :: Proxy UserAPI

type UserAPI =
  "users" :> Get '[JSON] [User]
  :<|> "users" :> Capture "x" Int :> Get '[JSON] [User]
  :<|> "users.male" :> Get '[JSON] [User]
  :<|> "users.female" :> Get '[JSON] [User]
  :<|> "users.more" :> Capture "x" Int :> Get '[JSON] [User :. Club]

userServer :: Server UserAPI
userServer = do
  getUsers
  :<|> getUser
  :<|> getMales
  :<|> getFemales
  :<|> getUserMore
  where
    getUsers = liftOp User.Op.index
    getUser id = liftOp $ User.Op.find id
    getMales = liftOp User.Op.males
    getFemales = liftOp User.Op.females
    getUserMore id = liftOp $ User.Op.more id

liftOp op = liftIO op >>= return
