{-# LANGUAGE OverloadedStrings #-}

module App (startApp)
 where

import           Control.Monad.Free
import           Servant.Client.Free   (ClientF (Throw, RunRequest))

import Network.HTTP.Client   (newManager, withResponse, responseStatus, responseHeaders,
                              responseBody)
import Network.HTTP.Client.Conduit (bodyReaderSource)

import Data.Aeson.Parser (json)
import Data.Aeson (Value (Array))
import Data.Aeson (fromJSON)

import Data.Conduit (runConduit, (.|))
import Data.Conduit.Attoparsec (sinkParser)

import Network.HTTP.Client.TLS   (tlsManagerSettings)
import Network.HTTP.Types.Status (statusCode)

import Servant.Client   (parseBaseUrl)

import Servant.Client.Internal.HttpClient (requestToClientRequest)

--import           Data.Aeson            (Value)
import Network.HTTP.Client as NHC
--import Network.HTTP.Simple as NHS

--import Prelude as P
--
--import Streamly
--import Streamly.Prelude as S
--
--import qualified Data.ByteString.Char8 as DBC
--import qualified Data.Yaml             as DY

import Util
import Handler   (callAPI, getItem, getUser)

import Constants   (uri)
import Data.Aeson.Types (Result, Array)

startApp :: IO ()
startApp = do
  putStrLn "\nStarting Hacker News client ..."
  nobuff
--  i <- readInt "\nEnter the number of the desired item: "

  case callAPI "topstories" of
--  case getItem i of
--  case getItem "1" of
--  case getUser "jl" of
    Free (RunRequest request responseHandler) -> do
      u <- parseBaseUrl uri
      m <- newManager tlsManagerSettings

      let r = requestToClientRequest u request
      putStrLn $ "Making request:\n"
      print r

--      response <- NHS.httpJSON r m

      withResponse r m $
       \response -> do

        putStrLn $ "\nResponse Status Code:"
        print $ statusCode $ responseStatus response

        putStrLn $ "\nResponse Headers:"
        print $ responseHeaders response

        {- We are only interested in the first 30 top stories -}
        putStrLn $ "\nResponse Body:"
        body <- runConduit ((.|) (bodyReaderSource (responseBody response))
                                 (sinkParser json))
        print body
--        fromJSON (body :: Value)

--      ss <- S.toList $ getStream b 30
--      print ss
        putStrLn $ "\n"

    Pure n ->
        putStrLn $ "\nERROR: got pure result:\n" ++ show n

    Free (Throw err) ->
        putStrLn $ "\nERROR: got error right away:\n" ++ show err

--    Free (StreamingRequest _req _k) ->
--        putStrLn $ "ERROR: need to do streaming request"


-- | Takes a JSON response body (b) and an Int (i) and returns a Streamly
--   stream comprising i elements of b
--getStream :: (IsStream t) =>
-- [Int] ->
-- Int ->
-- t IO Int
--getStream ss n = S.fromList $ P.take n ss
--

