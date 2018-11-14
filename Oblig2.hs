module Oblig2 where 
    -- Mitt-UiB brukernavn:     nuc006

import Data.Char
import Data.List

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
-- Grammar uses prefix notation. Therefore, read from right to left
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

---------------------- Oppgave 1.2 ----------------------------------
prettyPrint :: Expr -> IO () 
prettyPrint expr = do
    putStrLn $ printExpr expr 0

printExpr :: Expr -> Int -> String
printExpr (Mult a b) t = printExpr' "Mult" [a,b] t
printExpr (Add a b) t = printExpr' "Add" [a,b] t
printExpr (Neg a) t = printExpr' "Neg" [a] t
printExpr e@(Num a) t = printExpr' (show e) [] t
printExpr (If c a b) t = printExpr' "If" [c,a,b] t

printExpr' :: String -> [Expr] -> Int -> String
printExpr' name xs t = [' ' | n <- [1..(t*4)]] ++ name ++ "\n" ++ (concat [printExpr x (t+1) | x <- xs])

---------------------- Oppgave 1.3 ----------------------------------
takeOneStep :: Expr -> Expr 
takeOneStep expr = undefined 


---------------------- Oppgave 1.4 ----------------------------------
mainStep :: Expr -> IO ()
mainStep expr = undefined 