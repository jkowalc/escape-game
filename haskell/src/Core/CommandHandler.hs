module Core.CommandHandler where

import Core.Command (Command(..), printHelp)
import Util.IO (printLines)
import State.GameState (GameState)
import Control.Exception (handle)

handleCommand :: Command -> GameState -> IO GameState

handleCommand Look state = do
    printLines ["You are looking around."]
    return state

handleCommand Quit state = do
    printLines ["Goodbye!"]
    return state

handleCommand (Go place) state = do
    printLines ["You are going to " ++ show place ++ "."]
    return state

handleCommand Help state = do
    printHelp
    return state