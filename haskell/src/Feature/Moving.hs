module Feature.Moving where
import State.GameState (GameState (currentPlace, alarmRings))
import Object.Place (Place)
import Feature.Path (pathExists, possibleDestinations)
import qualified Data.Set as Set
import Util.IO (printLines, formatThing)
import Feature.Subplace (possibleSubplaces)
import Feature.ItemAt (itemsAtPlace)
import MapEventHandler.OnArrival (onArrival)

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

go :: Place -> GameState -> IO GameState
go place state
    | pathExists (currentPlace state, place) state = do
        newState <- onArrival place state
        printPossibilities newState { currentPlace = place }
        return newState { currentPlace = place }
    | alarmRings state = do
        putStrLn "The sound of the alarm clock is so disturbing that I can't go there. I have to go to the desk to disable it!"
        return state
    | otherwise = do
        putStrLn "You can't go there!"
        return state