{-# LANGUAGE DefaultSignatures, DeriveGeneric, TypeOperators, FlexibleContexts, FlexibleInstances, ScopedTypeVariables #-}

module TestGenericAST where 

import GHC.Generics


data GenericAST = GenericAST {
    name :: Name,
    children :: [GenericAST]
} deriving (Eq, Show)

type Name = String 


class Generalise b where 
    toGeneric :: b -> GenericAST

    default toGeneric :: (Generic b, GGeneralise (Rep b)) => b -> GenericAST
    toGeneric = head . gtoGeneric . from


-- Need to make it a list, because of children 
class GGeneralise f where 
    gtoGeneric :: f a -> [GenericAST]

-- | Unit: User for constructors without arguments 
instance GGeneralise U1 where 
    gtoGeneric U1 = [] -- [GenericAST "Unit" []]

-- | Constants, additional parameters and recursion of kind *
instance (GGeneralise a, GGeneralise b) => GGeneralise (a :*: b) where
    gtoGeneric (a :*: b) = gtoGeneric a ++ gtoGeneric b 

-- | Meta-information (constructor names, etc.)
-- TROR IKKE DETTE TRENGER VÆRE MER KOMPLISERT, bryr meg ikke om hvor noden ligger 
instance (GGeneralise a, GGeneralise b) => GGeneralise (a :+: b) where
    gtoGeneric (L1 x) = gtoGeneric x
    gtoGeneric (R1 x) = gtoGeneric x

-- Datatype
instance (GGeneralise f) => GGeneralise (M1 D c f) where
    gtoGeneric (M1 x) = [GenericAST nodeName children]
        where 
            nodeName = "DummyNameM1"
            children = gtoGeneric x

-- Constructor Metadata
instance (GGeneralise f, Constructor c) => GGeneralise (M1 C c f) where
    gtoGeneric (M1 x) = [GenericAST nodeName children]
        where 
            nodeName = conName (undefined :: t c f a)
            children = gtoGeneric x


-- Selector Metadata
instance (GGeneralise f, Selector c) => GGeneralise (M1 S c f) where
    gtoGeneric (M1 x) = [GenericAST nodeName children]
        where 
            -- m = (undefined :: t c g f)
            nodeName = "DummyNameM1"
            children = gtoGeneric x


-- Constructor Paramater
-- DETTE ER KONSTANTER, som feks i Num 1, så er dette 1
instance (Generalise f) => GGeneralise (K1 i f) where
    gtoGeneric (K1 x) = [GenericAST nodeName [toGeneric x]]
        where nodeName = "DummyNameValue " -- ++ somethingWith x




-------- Example 
data Tree = Leaf | Node Tree Tree deriving (Show, Generic)

instance Generalise Tree

instance Generalise Int where
    toGeneric i = GenericAST (show i) []
-- du må lage alle disse primitive typene, hvordan skal de representeres (string, char, bool, ...)

test = do 
    -- let tree = Leaf :: Tree
    let tree = Node Leaf Leaf :: Tree

    print (from tree)
    line 
    print (toGeneric tree :: GenericAST)

line = putStrLn ""