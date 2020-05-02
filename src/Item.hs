{-

Field        Description
-------------------------------------------------------------------------------
id            The item's unique id.
deleted      true if the item is deleted.
type          The type of item. One of "job", "story", "comment", "poll", or "pollopt".
by            The username of the item's author.
time          Creation date of the item, in Unix Time.
text          The comment, story or poll text. HTML.
dead          true if the item is dead.
parent        The comment's parent: either another comment or the relevant story.
poll          The pollopt's associated poll.
kids          The ids of the item's comments, in ranked display order.
url          The URL of the story.
score        The story's score, or the votes for a pollopt.
title        The title of the story, poll or job. HTML.
parts        A list of related pollopts, in display order.
descendants  In the case of stories or polls, the total comment count.

Ex of story -
https://hacker-news.firebaseio.com/v0/item/22843306.json?print=pretty
{
  "by" : "ColinWright",
  "id" : 22843306,
  "kids" : [ 22843693, 22845374, 22844167, 22843429, 22844186, 22843330, 22843572, 22846888, 22843431, 22847334, 22850841, 22844164, 22843826, 22853073, 22843390, 22844570, 22843847, 22843856, 22843583, 22843567, 22844451, 22844901, 22843418, 22843387, 22845086, 22843704, 22843413, 22845523, 22846124, 22846157, 22846658, 22843426, 22853647, 22843827, 22846215, 22845498, 22844160, 22846848, 22843924, 22852773, 22843657, 22843531, 22850940, 22844026, 22844000, 22843517, 22844180, 22844068, 22843521, 22843718, 22843901, 22847107, 22844217, 22844177, 22843779, 22843620, 22845292, 22847676, 22844369, 22846940, 22843806, 22843711, 22846197, 22845301, 22847746, 22844088, 22843410, 22848428, 22849425, 22847470, 22844002, 22847517, 22843553, 22844780, 22843427, 22843597, 22843999, 22843888, 22845177, 22844720, 22846548, 22846176 ],
  "time" : 1586630768,
  "type" : "story",
  "score" : 2199,
  "descendants" : 168,
  "title" : "John Conway has died",
  "url" : "https://twitter.com/CardColm/status/1249038195880341505"
}

Ex of comment -
https://hacker-news.firebaseio.com/v0/item/2921983.json?print=pretty
{
  "by" : "norvig",
  "id" : 2921983,
  "kids" : [ 2922097, 2922429, 2924562, 2922709, 2922573, 2922140, 2922141 ],
  "parent" : 2921506,
  "text" : "Aw shucks, guys ... you make me blush with your compliments.<p>Tell you what, Ill make a deal: I'll keep writing if you keep reading. K?",
  "time" : 1314211127,
  "type" : "comment"
}

-}

{-# LANGUAGE DeriveGeneric #-}


module Item ( ItemD )
 where


import GHC.Generics ( Generic )

import Data.Aeson.Types (FromJSON)

--import ItemType ( ItemTypeD )


data ItemD = Item
 {
  id       :: Int ,
  by       :: String,
  itemType :: String,
  kids     :: [Int],
  title    :: String
 }
 deriving ( Show, Generic )

instance FromJSON ItemD
