module Handler ( callAPI, getItem, getUser)
 where

import Control.Monad.Free

import Servant.Client.Free ( ClientF )

import DotJSONSuffix ( DotJSONSuffixN (DotJSONSuffix) )
import Item
import User
import HandlerDetails ( v0, item, user )

callAPI               ::
 String               ->
 Free ClientF [ItemD]
callAPI a = v0 (DotJSONSuffix a) --(Just "pretty")

getItem             ::
 String             ->
 Free ClientF ItemD
getItem id = item (DotJSONSuffix id) --(Just "pretty")

getUser             ::
 String             ->
 Free ClientF UserD
getUser id = user (DotJSONSuffix id) --(Just "pretty")


