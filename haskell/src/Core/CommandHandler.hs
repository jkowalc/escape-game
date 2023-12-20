module Core.CommandHandler where

import Core.Command (Command(..), printHelp)
import Util.IO (printLines)
import State.GameState (GameState(..), currentPlace)
import Control.Exception (handle)
import MapEventHandler.OnExamine (onExamine)
import Feature.Inventory (dropItem, takeItem)

handleCommand :: Command -> GameState -> IO GameState

handleCommand Look state = do
    printLines ["You are looking around."]
    return state

handleCommand Quit state = do
    printLines ["Goodbye!"]
    return state

handleCommand (Go place) state = do
    printLines ["You are going to " ++ show place ++ "."]
    return $ state { currentPlace = place }  -- Update currentPlace in the state

handleCommand Examine state = do
    onExamine (currentPlace state) state

handleCommand (Take item) state = do
    takeItem item state
    
handleCommand (Drop item) state =
    dropItem item state

handleCommand Help state = do
    printHelp
    return state