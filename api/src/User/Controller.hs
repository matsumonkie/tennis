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

type Pst = Post

type UserAPI =
  "users"
    :> Get '[JSON] [User]

  :<|> "users"
    :> Capture "x" Int :> Get '[JSON] [User]

  :<|> "users2"
    :> ReqBody '[JSON] User :> Pst '[JSON] [User]

  :<|> "users.male"
    :> Get '[JSON] [User]

  :<|> "users.female"
    :> Get '[JSON] [User]

  :<|> "users.detailed"
    :> Capture "x" Int :> Get '[JSON] ([User], [Club])

userServer :: Server UserAPI
userServer = do
  getUsers
  :<|> getUser
  :<|> createUser
  :<|> getMales
  :<|> getFemales
  :<|> getDetailedUser
  where
    getUsers           = liftOp User.Op.index
    createUser user    = trace (show user) liftOp $ User.Op.find $ usrId user
    getUser id         = liftOp $ User.Op.find id
    getMales           = liftOp User.Op.males
    getFemales         = liftOp User.Op.females
    getDetailedUser id = liftOp $ User.Op.details id

liftOp op = liftIO op >>= return
