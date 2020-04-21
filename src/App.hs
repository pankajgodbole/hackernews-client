module App ( startApp )
 where

import           Control.Monad.Free
import           Servant.Client.Free ( ClientF (Throw, RunRequest) )

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


startApp :: IO ()
--startApp = do
--  -- | Create an HTTP client manager (m) and handle the response (r)
--  m <- newManager tlsManagerSettings
--  u <- parseBaseUrl uri
--  r <- runClientM
--        (handler i)
--        (mkClientEnv m (BU.BaseUrl Https uri port path))
--
--  case r of
--    -- | Report any error (e) or display the item (i)
--    Left e -> do
--      putStrLn "\nError -"
--      print e
--    Right i -> do
--      putStrLn "\nSuccess -"
--      putStrLn "\nItem"
--      print i

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

        res' <- httpLbs req' m
        putStrLn $ "Got response:\n" ++ show res'

    Pure n ->
        putStrLn $ "ERROR: got pure result:\n" ++ show n

    Free (Throw err) ->
        putStrLn $ "ERROR: got error right away:\n" ++ show err

--    Free (StreamingRequest _req _k) ->
--        putStrLn $ "ERROR: need to do streaming request"
