module Feature.Look where

import State.GameState (GameState (currentPlace))
import Feature.Path (possibleDestinations)
import Feature.Subplace (possibleSubplaces)
import Feature.ItemAt (itemsAtPlace)
import qualified Data.Set as Set
import Util.IO (printLines, formatThing)

printPossibleDestinations :: GameState -> IO ()
printPossibleDestinations state = do
    if Set.null (possibleDestinations (currentPlace state) state)
        then return ()
        else do
            putStrLn "Possible destinations: "
            printLines (Set.toList (Set.map formatThing (possibleDestinations (currentPlace state) state)))

printPossibleSubplaces :: GameState -> IO ()
printPossibleSubplaces state = do
    if null (possibleSubplaces (currentPlace state) state)
        then return ()
        else do
            putStrLn "There are interesting places around you: "
            printLines (map formatThing (possibleSubplaces (currentPlace state) state))

printPossibleItems :: GameState -> IO ()
printPossibleItems state = do
    if null (itemsAtPlace (currentPlace state) state)
        then return ()
        else do
            putStrLn "There are items around you: "
            printLines (map formatThing (itemsAtPlace (currentPlace state) state))

printPossibilities :: GameState -> IO ()
printPossibilities state = do
    printPossibleDestinations state
    printPossibleSubplaces state
    printPossibleItems state