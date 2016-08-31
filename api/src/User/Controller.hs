module User.Controller (
  userProxy
, userServer
) where

import Servant
import Control.Monad.Except
import Debug.Trace

import User.Route
import User.Op
import User.Json
import Club.Json

userProxy = Proxy :: Proxy UserAPI

liftOp op = liftIO op >>= return

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
