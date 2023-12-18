module Util.IO where

printLines :: [String] -> IO ()
printLines xs = putStr (unlines xs)