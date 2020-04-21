{-# LANGUAGE OverloadedStrings #-}

module App ( startApp )
 where

import           Control.Monad.Free
import           Servant.Client.Free ( ClientF (Throw, RunRequest) )

import Network.HTTP.Client as NHC
import Network.HTTP.Client ( newManager ,
                             defaultManagerSettings,
                             httpLbs)
import Network.HTTP.Client.TLS ( tlsManagerSettings )
import Servant.Client ( runClientM,
                        mkClientEnv,
                        parseBaseUrl )
import Servant.Client.Core ( Scheme (Http) )
import Servant.Client.Core.BaseUrl as BU

import Servant.Client.Internal.HttpClient (requestToClientRequest)

import Util
import Handler ( getTopStories, getItem, getUser )

import Constants ( uri )

import           Data.Aeson            (Value)
import qualified Data.ByteString.Char8 as DBC
import qualified Data.Yaml             as DY
import           Network.HTTP.Simple   as NHS


startApp :: IO ()
startApp = do
  putStrLn "\nStarting Hacker News client ..."
  nobuff
--  i <- readInt "\nEnter the number of the desired item: "

--  case getTopStories "topstories" of
--  case getItem i of
--  case getItem "1" of
  case getUser "jl" of
    Free (RunRequest r responseHandler) -> do
        u  <- parseBaseUrl uri
        m   <- newManager tlsManagerSettings

        let req' = requestToClientRequest u r
        putStrLn $ "Making request:\n" ++ show req'

        response <- NHC.httpLbs req' m
        putStrLn $ "\nResponse Status Code:\n"           ++
                   show (getResponseStatusCode response)
        putStrLn $ "\nResponse Headers:\n"            ++
                   show (getResponseHeaders response)
        putStrLn $ "\nResponse Body:\n"            ++
                   show (getResponseBody response)

    Pure n ->
        putStrLn $ "\nERROR: got pure result:\n" ++ show n

    Free (Throw err) ->
        putStrLn $ "\nERROR: got error right away:\n" ++ show err

--    Free (StreamingRequest _req _k) ->
--        putStrLn $ "ERROR: need to do streaming request"
