{-# LANGUAGE DataKinds #-}
{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE TypeOperators #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE KindSignatures #-}
{-# LANGUAGE TypeSynonymInstances #-}
{-# LANGUAGE FlexibleContexts #-}
module Main where 
    -- Mitt-UiB brukernavn:     [DITT BRUKERNAVN HER]

import Data.Char
import Client (visualise)
import Types -- importerer datatypen Expr, så du skal ikke lime den inn her 
import GHC.Generics

main = do 
    let testExpr2 = Num 3
    print testExpr2
    print $ from $ testExpr2

    putStrLn ""
    let testExpr = Add (Num 2) (Num 4)
    print testExpr
    print $ from $ testExpr

    putStrLn ""
    let testExpr3 = Mult (Num 2) (Num 3)
    print testExpr3
    print $ from $ testExpr3
    
    putStrLn ""
    let testExpr2 = Neg (Num 3)
    print testExpr2
    print $ from $ testExpr2

    putStrLn ""
    let testExpr2 = If (Num 1) (Num 2) (Num 3)
    print testExpr2
    print $ from $ testExpr2


data AST 
    = Null 
    | En String String Int 
    deriving (Show, Generic)

repTest = do 
    let testExpr2 = En "A" "B" 2
    print testExpr2
    print $ from $ testExpr2
    
--     let rep = from $ testExpr2 
--     print $ getConstructorName rep 

-- getConstructorName (M1 {unM1 = R1 (M1 val)}) = conName val
-- getConstructorName (M1 {unM1 = L1 val}) = conName val
--getConstructorName _ = 0
--                  M1 {unM1 = R1 (M1 {unM1 = M1 {unM1 = K1 {unK1 = 1}}})}


    -- let testExpr2 = To 1
    -- print testExpr2
    -- print $ from $ testExpr2
    -- putStrLn "" 

    -- let testExpr2 = Tre 1
    -- print testExpr2
    -- print $ from $ testExpr2
    -- putStrLn "" 

    -- let testExpr2 = Fire 1
    -- print testExpr2
    -- print $ from $ testExpr2


-- Oppgave 1.4 og 2.1 - LIM INN IMPLEMENTASJONEN FRA DEL 1 HER, OG UTVID
mainStep :: Expr -> IO ()
mainStep expr = undefined 


-- Oppgave 1.3 - LIM INN IMPLEMENTASJONEN FRA DEL 1 HER
takeOneStep :: Expr -> Expr 
takeOneStep expr = undefined 
   

-- Oppgave 1.2 - LIM INN IMPLEMENTASJONEN FRA DEL 1 HER
prettyPrint :: Expr -> IO () 
prettyPrint expr = undefined 


-- Oppgave 1.1 - LIM INN IMPLEMENTASJONEN FRA DEL 1 HER (inkludert hjelpefunksjoner)
parse :: String -> Expr 
parse expr = undefined 


------------ FERDIG IMPLEMENTERTE HJELPEFUNKSJONER (IKKE RØR) ------------------  

{-
Evaluator som skal brukes når du skal visualisere med visAST. 
Denne kaller på takeOneStep helt til Expr er blitt et Num,
og returnerer listen med alle "tilstandene" Expr er i før den blir et Num (en verdi)
-}
eval :: Expr -> [Expr]
eval (Num num) = [Num num] 
eval expr = 
    expr : eval (takeOneStep expr)