module Main where 


import Parser -- Denne importerer parse funksjonen så du kan teste prettyPrint på strenger


{- Du kan teste prettyPrint slik: prettyPrint (parse "+ 4 5")
-}


-- Oppgave 1.1
prettyPrint :: Expr -> IO () 
prettyPrint = undefined 


-- Oppgave 1.2 
takeOneStep :: Expr -> Expr 
takeOneStep = undefined 



{- eval - ikke rør denne
Evaluator som skal brukes når du skal visualisere med visAST. 
Denne kaller på takeOneStep helt til Expr er blitt et Num,
og returnerer listen med alle "tilstandene" Expr er i før den blir et Num (en verdi)
-}
eval :: Expr -> [Expr]
eval (Num num) = [Num num] 
eval expr = 
    expr : eval (takeOneStep expr)
