{-# LANGUAGE DataKinds #-}
{-# LANGUAGE TypeOperators #-}

module Client where

import Data.Aeson
import Data.Proxy
import GHC.Generics
import Network.HTTP.Client (newManager, defaultManagerSettings)
import Servant.API
import Servant.Client
import Types
import Web.Browser (openBrowser)


-- Public function for students to use to trigger visAST
visualise :: String -> [GenericAST] -> IO () 
visualise key steps = do 
    putStrLn "Sending trees to visAST..."
    run key steps 
    openBrowser "https://vis-ast.netlify.com" >>= print 


type API = "easy" :> ReqBody '[JSON] InputString :> Post '[JSON] [GenericAST]
    :<|> "advanced" :> Capture "studentKey" String :> ReqBody '[JSON] Steps :> Put '[JSON] ResponseMsg
    :<|> "advanced" :> QueryParam "studentKey" String :> Get '[JSON] [GenericAST]


easy :<|> advancedPut :<|> advancedGet = client (Proxy :: Proxy API)


run :: String -> [GenericAST] -> IO () 
run key steps = do 
    manager' <- newManager defaultManagerSettings
    let url = BaseUrl Http "visast-api-prod.herokuapp.com" 80 ""
        query = advancedPut key (Steps { evalSteps = steps })
    res <- runClientM query (mkClientEnv manager' url)
    case res of 
        Left err -> 
            putStrLn "Oops, something went wrong..."
        Right responseStr -> 
            putStrLn $ "Success: Evaluation steps stored at visAST."