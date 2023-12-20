module Core.CommandHandler where

import Core.Command (Command(..), printHelp)
import Util.IO (printLines)
import State.GameState (GameState(..), currentPlace)
import Control.Exception (handle)
import MapEventHandler.OnExamine (examine)
import MapEventHandler.OnEnterCode (enterCode)

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
    examine (currentPlace state)
    return state
    
handleCommand (EnterCode userCode lock) state = do
    enterCode state userCode (show lock)

handleCommand Help state = do
    printHelp
    return state

handleCommand _ state = do
    printLines ["Unknown command!"]
    return state
