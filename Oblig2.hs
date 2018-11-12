module Oblig2 where 

import Data.Char

data Expr 
    = Num Int 
    | Add Expr Expr 
    | Mult Expr Expr 
    | Neg Expr 
    | If Expr Expr Expr 
    deriving (Show, Read)

-- Du kan teste prettyPrint slik:
main = prettyPrint (parse "+ 4 5")


---------------------- Oppgave 1.1 ----------------------------------
parse :: String -> Expr 
parse str = undefined 


---------------------- Oppgave 1.2 ----------------------------------
prettyPrint :: Expr -> IO () 
prettyPrint expr = undefined 


---------------------- Oppgave 1.3 ----------------------------------
takeOneStep :: Expr -> Expr 
takeOneStep expr = undefined 


---------------------- Oppgave 1.4 ----------------------------------
mainStep :: Expr -> IO ()
mainStep expr = undefined 