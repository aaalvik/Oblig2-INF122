module TestParser where 

import Types -- importerer datatypen Expr, så du skal ikke lime den inn her 
import Client (visualise)
import Data.Char

-- IKKE RØR DENNE 
main :: IO ()
main = 
    putStrLn "Skriv inn mitt.uib brukernavnet ditt (abc123)" >> getLine >>= \b -> 
        putStrLn "Skriv inn et uttrykk" >> getLine >>= \l -> 
            visualise b [parse l]


-- Oppgave 1.1 - LIM INN IMPLEMENTASJONEN AV PARSEREN 1 HER (inkludert hjelpefunksjoner)
parse :: String -> Expr 
parse str = parse' (reverse $ tokenize str) []

tokenize :: String -> [String]
tokenize inp = tokenize' inp []

tokenize' :: String -> [String] -> [String]
tokenize' [] stack = reverse $ filter (/= []) (map (filter (/= ' ')) stack)
tokenize' (x:xs) stack
    | newToken x stack = tokenize' xs ([x]:stack)
    | otherwise = tokenize' xs (((head stack) ++ [x]):(tail stack))

newToken :: Char -> [String] -> Bool
newToken x [] = True
newToken x (y:ys) 
    | elem x "+*- " = True
    | otherwise = (isDigit x) /= (all (isDigit) y)

parse' :: [String] -> [Expr] -> Expr
parse' [] [expr] = expr                                          -- All input parsed. Return result
parse' ("*":xs) (a:b:stack) = parse' xs ((Mult a b):stack)       -- Parse Mult, then push it onto the stack
parse' ("+":xs) (a:b:stack) = parse' xs ((Add a b):stack)        -- Parse Add, then push it onto the stack
parse' ("-":xs) (a:stack) = parse' xs ((Neg a):stack)            -- Parse Neg, then push it onto the stack
parse' ("else":xs) stack = parseIf xs stack                      -- Parse if-statement
parse' (x:xs) stack
    | all (isDigit) x = parse' xs ((Num (read x :: Int)):stack)  -- Parse number
parse' _ _ = error "Illegal expression"

parseIf :: [String] -> [Expr] -> Expr
parseIf xs (else':stack) = parse' xs'' ((If cond then' else'):stack)
    where (then', xs') = parseUntil "then" xs
          (cond, xs'') = parseUntil "if" xs'

parseUntil :: String -> [String] -> (Expr,[String])
parseUntil e xs = parseUntil' e xs []

parseUntil' :: String -> [String] -> [String] -> (Expr,[String])
parseUntil' e (x:xs) stack
    | x == e = (parse' stack [], xs)
    | otherwise = parseUntil' e xs (stack ++ [x])
parseUntil' _ [] stack = (parse' stack [], [])
