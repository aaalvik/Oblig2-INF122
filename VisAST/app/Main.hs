{-# LANGUAGE DeriveGeneric #-}

module Main where 

    import GHC.Generics
    import Client (visualise)
    import GenericAST

    main = undefined 


    -- Brukerdefinert AST 
    data BoolExp 
        = Val Bool 
        | And BoolExp BoolExp
        | Or BoolExp BoolExp


    -- Parser 
    parse :: String -> BoolExp 
    parse = fst . parseExp . words

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


    -- Small-step evaluator 
    eval :: BoolExp -> [BoolExp]
    eval (Val x) = [Val x]
    eval exp = exp : eval (takeOneStep exp)

    
    takeOneStep :: BoolExp -> BoolExp 
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