module Main where 

import Client (visualise)
import Parser (parse)
import Types

{-
For å starte visAST kaller du på funksjonen visualise :: String -> [Expr] -> IO (), slik: visualise username exprs
-}


-- Ikke rør denne, du skal jobbe med mainStep-funksjonen under. 
main = do
    putStrLn "For å starte, skriv inn et uttrykk (feks + 2 3)"
    str <- getLine 
    case parse str of 
        Nothing -> do 
            putStrLn "Ugyldig uttrykk, prøv igjen."
            main 
        Just expr -> do 
            mainStep expr

    
-- Oppgave 2.1 og 2.2
mainStep :: Expr -> IO ()
mainStep expr = undefined 



{- eval
Evaluator som skal brukes når du skal visualisere med visAST. 
Denne kaller på takeOneStep helt til Expr er blitt et Num,
og returnerer listen med alle "tilstandene" Expr er i før den blir et Num (en verdi)
-}
eval :: Expr -> [Expr]
eval (Num num) = [Num num] 
eval expr = 
    expr : eval (takeOneStep expr)


-- TODO: Lim inn implementasjonen av denne fra Del1
prettyPrint :: Expr -> IO () 
takeOneStep expr = undefined 


-- TODO: Lim inn implementasjonen av denne fra Del1
takeOneStep :: Expr -> Expr 
takeOneStep expr = undefined 