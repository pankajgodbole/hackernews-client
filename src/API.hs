{-# LANGUAGE DataKinds,
             TypeOperators #-}

module API ( APIT )
 where


import Servant.API ( (:>),
                     (:<|>),
                     Get,
                     Capture,
                     QueryParam )

import Servant.API.ContentTypes ( JSON )

import DotJSONSuffix ( DotJSONSuffixN )
import Item ( ItemD )
import User ( UserD )

-- | Type reflecting HackerNews API
type APIT =
  "v0"                                :>
  Capture "topstories" DotJSONSuffixN :>
  --QueryParam "print" String           :>
  Get '[JSON] [ItemD]
  :<|>
  "v0"                                :>
  "item"                             :>
  Capture "id" DotJSONSuffixN :>
  --QueryParam "print" String          :>
  Get '[JSON] ItemD
  :<|>
  "v0"                                :>
  "user"                             :>
  Capture "id" DotJSONSuffixN :>
  --QueryParam "print" String          :>
  Get '[JSON] UserD
