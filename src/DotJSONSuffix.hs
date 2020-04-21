module DotJSONSuffix ( DotJSONSuffixN (..) )
 where

import Data.Monoid ( (<>) )

import qualified Data.Text as T
import Data.Text ( pack, takeWhileEnd, filter )
import Web.HttpApiData ( ToHttpApiData (..) ,
                         showTextData       )

newtype DotJSONSuffixN = DotJSONSuffix String
 deriving ( Eq, Show )

instance ToHttpApiData DotJSONSuffixN
 where
  toUrlPiece p = T.filter (/= '"') (takeWhileEnd (/= ' ') $ showTextData p <> pack ".json")
