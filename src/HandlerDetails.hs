module HandlerDetails ( v0, item, user)
 where

import Control.Monad.Free

import Servant.Client.Free as SCF
import Servant.Client.Free ( ClientF ,
                             client  )

import Servant.API ( (:<|>) ((:<|>)) )

import Data.Proxy ( Proxy (Proxy) )

import API ( APIT )
import DotJSONSuffix ( DotJSONSuffixN )
import Item
import User

v0                    ::
 DotJSONSuffixN       ->
 --Maybe String         ->
 Free ClientF [ItemD]

item                ::
 DotJSONSuffixN     ->
 --Maybe String       ->
 Free ClientF ItemD

user                ::
 DotJSONSuffixN     ->
 --Maybe String       ->
 Free ClientF UserD


v0 :<|> item :<|> user = SCF.client api

-- | A proxy for the HackerNews API
api :: Proxy APIT
api =  Proxy

