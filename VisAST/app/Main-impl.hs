{-# LANGUAGE DeriveGeneric #-}

module Main where 

import GHC.Generics
import GenericAST
import Client (visualise)
import Types

-- Definer et AST 
data BoolExp 
    = Val Bool 
    | And BoolExp BoolExp 
    | Or BoolExp BoolExp 
    | Not BoolExp
    deriving (Show, Generic)


instance Generalise BoolExp 
    where 
        toGeneric (Val bool) = toGeneric bool 
        toGeneric (And x y) = GenericAST node children
            where 
                node = "Og"
                children = [toGeneric x, toGeneric y]
        toGeneric x = head $ gtoGeneric $ from x -- default for all other cases


-- Skriv en parser 
parse :: String -> BoolExp 
parse str = 
    fst $ parseExp $ words str 


parseExp :: [String] -> (BoolExp, [String])
parseExp ("T":xs) = (Val True, xs)
parseExp ("F":xs) = (Val False, xs)
parseExp ("and":xs) = (And left right, rest')
    where
        (left, rest) = parseExp xs
        (right, rest') = parseExp rest
parseExp ("or":xs) = (Or left right, rest')
    where
        (left, rest) = parseExp xs
        (right, rest') = parseExp rest
parseExp ("not":xs) = (Not exp, rest)
    where
        (exp, rest) = parseExp xs


takeOneStep (And (Val x) (Val y)) = 
    Val $ x && y
takeOneStep (And (Val x) y) =
    And (Val x) (takeOneStep y)
takeOneStep (And x y) =
    (And (takeOneStep x) y)
takeOneStep (Or (Val x) (Val y)) =
    Val $ x || y
takeOneStep (Or (Val x) y) =
    Or (Val x) (takeOneStep y)
takeOneStep (Or x y) =
    (Or (takeOneStep x) y)
takeOneStep (Not (Val x)) =
    Val $ not x
takeOneStep (Not x) =
    Not $ takeOneStep x

eval :: BoolExp -> [BoolExp]
eval (Val b) = [Val b]
eval exp = exp : eval (takeOneStep exp)

-- Kall på visualise i main 
main = do 
    str <- getLine 
    let exp = parse str 
    visualise "demo" (eval exp)