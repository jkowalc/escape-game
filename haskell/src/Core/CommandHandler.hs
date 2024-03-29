module Core.CommandHandler where

import Core.Command (Command(..), printHelp)
import Util.IO (printLines)
import State.GameState (GameState(..), currentPlace)
import Control.Exception (handle)
import Feature.Inventory (dropItem, takeItem, printInventory)
import Feature.Examine (examinePlace, examineItem)
import Feature.Moving (go)
import Feature.Look (printPossibilities)
import Feature.Use (useOnPlace, useOnItem)
import Feature.Combine (combine)
import Feature.EnterCode (enterCode)

handleCommand :: Command -> GameState -> IO GameState

handleCommand Look state = do
    printPossibilities state
    return state

handleCommand Quit state = do
    printLines ["Goodbye!"]
    return state

handleCommand (Go place) state = do
    go place state

handleCommand Examine state = do
    examinePlace (currentPlace state) state

handleCommand (ExamineItem item) state = do
    examineItem item state

handleCommand (ExaminePlace place) state = do
    examinePlace place state

handleCommand (Take item) state = do
    takeItem item state

handleCommand (Drop item) state =
    dropItem item state

handleCommand Inventory state = do
    printInventory state
    return state
    
handleCommand (EnterCode userCode place) state = do
    enterCode userCode place state

handleCommand (Use item) state = do
    useOnPlace item (currentPlace state) state

handleCommand (UseOnPlace item place) state = do
    useOnPlace item place state

handleCommand (UseOnItem item1 item2) state = do
    useOnItem item1 item2 state

handleCommand (Combine item1 item2) state = do
    combine item1 item2 state

handleCommand Help state = do
    printHelp
    return state

handleCommand _ state = do
    printLines ["Unknown command!"]
    return state
