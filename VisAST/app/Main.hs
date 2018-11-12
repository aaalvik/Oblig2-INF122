module Main where 

import Data.Char
import Client (visualise)
import Types -- Denne importerer datatypen Expr, så du skal ikke lime den inn her 

main = mainStep (Add (Num 2) (Num 3)) -- Default expression til å begynne med 


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