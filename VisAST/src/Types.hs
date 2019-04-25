{-# LANGUAGE DeriveGeneric #-}

module Types where

import Data.Aeson
import GHC.Generics

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


data Steps = Steps { 
    evalSteps :: [GenericAST]
} deriving (Show, Generic)
instance ToJSON Steps