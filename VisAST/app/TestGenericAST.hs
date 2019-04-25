{-# LANGUAGE DefaultSignatures, DeriveGeneric, TypeOperators, FlexibleContexts, FlexibleInstances #-}
module TestGenericAST where 

import GHC.Generics


data GenericAST = GenericAST {
    name :: Name,
    children :: [GenericAST]
} deriving (Eq, Show)

type Name = String 


class Generalise a where 
    toGeneric :: a -> GenericAST

    default toGeneric :: (Generic a, GGeneralise (Rep a)) => a -> GenericAST
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

-- | Sums: encode choice between constructors
-- HER MÅ JEG LAGRE NAVNET PÅ KONSTRUKTØREN 

-- Datatype
instance (GGeneralise a) => GGeneralise (M1 D c a) where
    gtoGeneric (M1 x) = [GenericAST nodeName children]
        where 
            nodeName = "DummyNameM1"
            children = gtoGeneric x

-- Constructor Metadata
instance (GGeneralise a, Constructor c) => GGeneralise (M1 C c a) where
    gtoGeneric (M1 x) = [GenericAST nodeName children]
        where 
            m = (undefined :: t c a b)
            nodeName = conName m
            children = gtoGeneric x

-- Selector Metadata
instance (GGeneralise a) => GGeneralise (M1 S c a) where
    gtoGeneric (M1 x) = [GenericAST nodeName children]
        where 
            nodeName = "DummyNameM1"
            children = gtoGeneric x



-- | Products: encode multiple arguments to constructors
-- DETTE ER KONSTANTER, som feks i Num 1, så er dette 1
instance (Generalise a) => GGeneralise (K1 i a) where
    gtoGeneric (K1 x) = [GenericAST nodeName [toGeneric x]]
        where nodeName = "DummyNameValue " -- ++ somethingWith x



-------- Example 
data Tree = Leaf | Node Int (Tree) (Tree) deriving (Show, Generic)

instance Generalise Tree

instance Generalise Int where
    toGeneric i = GenericAST (show i) []
-- du må lage alle disse primitive typene, hvordan skal de representeres (string, char, bool, ...)

test = do 
    -- let tree = Leaf :: Tree
    let tree = Node 4 Leaf Leaf :: Tree

    print (from tree)
    line 
    print (toGeneric tree :: GenericAST)

line = putStrLn ""