module Oblig2 where 

import Data.Char


data Expr 
    = Num Int 
    | Add Expr Expr 
    | Mult Expr Expr 
    | Neg Expr 
    | If Expr Expr Expr 
    deriving (Show, Read)

--Du kan teste prettyPrint slik: prettyPrint (parse "+ 4 5")
main = prettyPrint (parse "+ 4 5")


-- Oppgave 1.1
prettyPrint :: Expr -> IO () 
prettyPrint expr = undefined 


-- Oppgave 1.2 
takeOneStep :: Expr -> Expr 
takeOneStep expr = undefined 



{- eval - ikke rør denne
Evaluator som skal brukes når du skal visualisere med visAST. 
Denne kaller på takeOneStep helt til Expr er blitt et Num,
og returnerer listen med alle "tilstandene" Expr er i før den blir et Num (en verdi)
-}
eval :: Expr -> [Expr]
eval (Num num) = [Num num] 
eval expr = 
    expr : eval (takeOneStep expr)
        

-------------------------- PARSER -----------------------
parse :: String -> Expr 
parse str = 
    let 
        tokens = tokenize str 
    in 
        case parseExpr tokens of 
            (Just expr, []) -> 
                expr 
            _ -> error "Parsing failed" -- parsing failed somehow


tokenize :: String -> [String]
tokenize [] = [] 
tokenize (' ':xs) = tokenize xs 
tokenize s@(x:xs) 
    | elem x "+*-" = [x] : tokenize xs 
    | isDigit x = (takeWhile isDigit s) : tokenize (dropWhile isDigit s)
tokenize ('i':'f':xs) = "if" : tokenize xs 
tokenize ('t':'h':'e':'n':xs) = "then" : tokenize xs 
tokenize ('e':'l':'s':'e':xs) = "else" : tokenize xs 


parseExpr :: [String] -> (Maybe Expr, [String])
parseExpr (x:xs) | all isDigit x = 
    (Just $ Num $ read x, xs)
parseExpr ("+":xs) =
    let 
        (me1, rest) = parseExpr xs 
        (me2, rest') = parseExpr rest 
    in 
        case (me1, me2) of 
            (Just e1, Just e2) -> 
                (Just $ Add e1 e2, rest')
            _ -> (Nothing, [])
parseExpr ("*":xs) =
    let 
        (me1, rest) = parseExpr xs 
        (me2, rest') = parseExpr rest 
    in 
        case (me1, me2) of 
            (Just e1, Just e2) -> 
                (Just $ Mult e1 e2, rest')
            _ -> (Nothing, [])
parseExpr ("-":xs) = 
    let 
        (me, rest) = parseExpr xs 
    in 
        (fmap Neg me, rest)
parseExpr ("if":xs) = 
    let 
        (meCond, restCond) = parseExpr xs                -- rest should start with "then"
        (meThen, restThen) = parseExpr $ tail restCond   -- rest should start with "else"
        (meElse, restElse) = parseExpr $ tail restThen
    in 
        case (meCond, meThen, meElse) of 
            (Just eCond, Just eThen, Just eElse) ->
                if head restCond == "then" && head restThen == "else" then 
                    (Just $ If eCond eThen eElse, restElse)
                else (Nothing, [])
            _ -> (Nothing, [])
parseExpr e = (Nothing, [])