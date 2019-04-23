{-# LANGUAGE DefaultSignatures, DeriveGeneric, TypeOperators, FlexibleContexts #-}
import GHC.Generics
-- import Data.Bits 

data GenericAST = GenericAST {
    name :: Name,
    children :: [GenericAST]
} deriving (Eq, Show)

type Name = String 


class Generalise a where 
    toGeneric :: a -> GenericAST

    default toGeneric :: (Generic a, GGeneralise (Rep a)) => a -> GenericAST
    toGeneric a = head $ gtoGeneric (from a)


-- Need to make it a list, because of children 
class GGeneralise f where 
    gtoGeneric :: f a -> [GenericAST]

-- | Unit: User for constructors without arguments 
instance GGeneralise U1 where 
    gtoGeneric U1 = [GenericAST "Unit" []]

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
instance (GGeneralise a) => GGeneralise (M1 i c a) where
    gtoGeneric (M1 x) = [GenericAST nodeName children]
        where 
            nodeName = "DummyNameM1"
            children = gtoGeneric x

-- | Products: encode multiple arguments to constructors
-- DETTE ER KONSTANTER, som feks i Num 1, så er dette 1
instance (Generalise a) => GGeneralise (K1 i a) where
    gtoGeneric (K1 x) = [GenericAST nodeName []]
        where nodeName = "DummyNameValue " -- ++ somethingWith x



-------- Example 
-- data Tree a = Leaf | Node a (Tree a) (Tree a) deriving (Show, Generic)
data Tree = Leaf | Node String (Tree) (Tree) deriving (Show, Generic)

-- instance (Generalise a) => Generalise (Tree a)

instance Generalise Tree

testToGeneric = do 
    let tree = Leaf :: Tree 
    print (toGeneric tree :: GenericAST)