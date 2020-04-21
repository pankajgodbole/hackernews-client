module Handler ( getTopStories, getItem, getUser)
 where

import Control.Monad.Free

import Servant.Client.Free ( ClientF )

import DotJSONSuffix ( DotJSONSuffixN (DotJSONSuffix) )
import Item
import User
import HandlerDetails ( v0, item, user )

getTopStories         ::
 String               ->
 Free ClientF [ItemD]
getTopStories p = v0 (DotJSONSuffix p) --(Just "pretty")

getItem             ::
 String             ->
 Free ClientF ItemD
getItem id = item (DotJSONSuffix id) --(Just "pretty")

getUser             ::
 String             ->
 Free ClientF UserD
getUser id = user (DotJSONSuffix id) --(Just "pretty")

