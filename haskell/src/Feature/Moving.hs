module Feature.Moving where
import State.GameState (GameState (currentPlace, alarmRings))
import Object.Place (Place)
import Feature.Path (pathExists, possibleDestinations)
import Util.IO (printLines, formatThing)
import Feature.Subplace (possibleSubplaces)
import Feature.ItemAt (itemsAtPlace)
import MapEventHandler.OnArrival (onArrival)
import Feature.Look (printPossibilities)

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