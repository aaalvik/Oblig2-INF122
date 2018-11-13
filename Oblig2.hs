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
parse str = parse' (reverse $ words str) []

-- Reads input. Encountered sub-expressions are parsed, then added to the stack, before continuing.
-- (The function is therefore tail-recursive).
parse' :: [String] -> [Expr] -> Expr
parse' [] [expr] = expr
parse' [] stack = error $ "Unresolved expressions on stack: " ++ (show stack)
parse' ("*":xs) (a:b:stack) = parse' xs ((Mult a b):stack)       -- Parse Mult, then push it onto the stack
parse' ("+":xs) (a:b:stack) = parse' xs ((Add a b):stack)        -- Parse Add, then push it onto the stack
parse' ("-":xs) (a:stack) = parse' xs ((Neg a):stack)            -- Parse Neg, then push it onto the stack
parse' ("else":xs) stack = parseIf xs stack                      -- Parse if-statement
parse' inp@(x:xs) stack
    | all (isDigit) x = parse' xs ((Num (read x :: Int)):stack)  -- Parse number
    | otherwise = error $ "Invalid syntax: " ++ (intersperse ' ' $ concat $ reverse inp)

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
prettyPrint expr = undefined 


---------------------- Oppgave 1.3 ----------------------------------
takeOneStep :: Expr -> Expr 
takeOneStep expr = undefined 


---------------------- Oppgave 1.4 ----------------------------------
mainStep :: Expr -> IO ()
mainStep expr = undefined 