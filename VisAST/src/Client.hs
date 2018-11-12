{-# LANGUAGE DataKinds #-}
{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE TypeOperators #-}

module Client where

import Data.Aeson
import Data.Proxy
import GHC.Generics
import Network.HTTP.Client (newManager, defaultManagerSettings)
import Servant.API
import Servant.Client
import Types
import Convert (toGeneric)
import Web.Browser (openBrowser)


-- Public function for students to use to trigger visAST
visualise :: String -> [Expr] -> IO () 
visualise key steps = do 
    putStrLn "Sender uttrykk til visAST... (kan ta litt tid hvis serveren sover)"
    run key steps 
    openBrowser "https://vis-ast.netlify.com" >>= print 


type API = "steps" :> ReqBody '[JSON] InputString :> Post '[JSON] [GenericAST]
      :<|> "putStepsFromStudent" :> ReqBody '[JSON] StepsWithKey :> Post '[JSON] ResponseMsg
      :<|> "getStepsFromStudent" :> QueryParam "studentKey" String :> Get '[JSON] [GenericAST]

api :: Proxy API
api = Proxy

steps :<|> putStepsFromStudent :<|> getStepsFromStudent = client api


query :: String -> [Expr] -> ClientM ResponseMsg 
query key steps = do 
    response <- putStepsFromStudent (StepsWithKey { evalSteps = (map toGeneric steps), key = key })
    return response 


run :: String -> [Expr] -> IO () 
run key steps = do 
    manager' <- newManager defaultManagerSettings
    let url = BaseUrl Http "visast-api-prod.herokuapp.com" 80 ""
    res <- runClientM (query key steps) (mkClientEnv manager' url)
    case res of 
        Left err -> --putStrLn $ "Error: " ++ show err 
            putStrLn "Oops, noe gikk galt... Send en mail til ragnhild.aalvik@gmail.com hvor du beskriver feilen."
        Right responseStr -> 
            -- DO SOMETHING USEFUL 
            putStrLn $ "Vellykket: Lagret evalueringssteg hos visAST."
 