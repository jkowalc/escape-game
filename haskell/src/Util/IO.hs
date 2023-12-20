module Util.IO where

printLines :: [String] -> IO ()
printLines xs = putStr (unlines xs)

formatThing :: Show a => a -> String
formatThing thing = "- " ++ show thing