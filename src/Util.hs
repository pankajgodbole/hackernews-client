module Util where

import System.IO (hSetBuffering, hFlush, stdout, BufferMode (NoBuffering))

-- | Disables output buffering
nobuff :: IO ()
nobuff = hSetBuffering stdout NoBuffering

-- | Takes an message prompt (m), and returns an action which when
--   performed accepts a String and outputs an Int
readInt :: String -> IO Int
readInt m = do
  putStr (m ++ "> ")
  hFlush stdout
  readLn