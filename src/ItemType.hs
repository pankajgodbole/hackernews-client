{-# LANGUAGE DeriveGeneric #-}


module ItemType ( ItemTypeD )
 where


import GHC.Generics ( Generic )

data ItemTypeD =
  Story | Comment | Job | Poll | PollOpt
 deriving ( Show, Eq, Generic )
