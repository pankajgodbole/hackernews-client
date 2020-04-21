module ItemIdWithJSONSuffix ( ItemIdWithJSONSuffixN (..))
 where

import Web.HttpApiData ( ToHttpApiData (..),
                         showTextData)
import Data.Text ( pack, takeWhileEnd )
import Data.Monoid ( (<>) )

newtype ItemIdWithJSONSuffixN = ItemIdWithJSONSuffix Integer
 deriving ( Eq, Show )

instance Num ItemIdWithJSONSuffixN
 where
  fromInteger = ItemIdWithJSONSuffix

instance ToHttpApiData ItemIdWithJSONSuffixN
 where
  toUrlPiece i = takeWhileEnd (/= ' ') (showTextData i <> pack ".json")
