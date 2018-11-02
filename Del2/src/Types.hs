{-# LANGUAGE DataKinds #-}
{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE TypeOperators #-}

module Types where

import Data.Aeson
import Data.Proxy
import GHC.Generics
import Network.HTTP.Client (newManager, defaultManagerSettings)
import Servant.API
import Servant.Client

data Expr 
    = Num Int 
    | Add Expr Expr 
    | Mult Expr Expr 
    | Neg Expr 
    | If Expr Expr Expr 
    deriving (Eq, Show)


data GenericAST = GenericAST {
    name :: Name,  
    children :: [GenericAST]
} deriving (Eq, Show, Generic)
instance ToJSON GenericAST  
instance FromJSON GenericAST 


type Name = String 


newtype ResponseMsg = ResponseMsg { 
    resStr :: String 
} deriving (Show, Generic)
instance FromJSON ResponseMsg 


newtype InputString = InputString { 
    inputStr :: String 
} deriving (Eq, Show, Generic)
instance ToJSON InputString
instance FromJSON InputString 


data StepsWithKey = StepsWithKey { 
    evalSteps :: [GenericAST], 
    key :: String 
} deriving (Show, Generic)
instance ToJSON StepsWithKey