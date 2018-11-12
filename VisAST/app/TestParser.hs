module TestParser where 

import Types -- importerer datatypen Expr, så du skal ikke lime den inn her 
import Client (visualise)

-- IKKE RØR DENNE 
main :: IO ()
main = 
    putStrLn "Skriv inn mitt.uib brukernavnet ditt (abc123)" >> getLine >>= \b -> 
        putStrLn "Skriv inn et uttrykk" >> getLine >>= \l -> 
            visualise b [parse l]


-- Oppgave 1.1 - LIM INN IMPLEMENTASJONEN AV PARSEREN 1 HER (inkludert hjelpefunksjoner)
parse :: String -> Expr 
parse expr = undefined 
