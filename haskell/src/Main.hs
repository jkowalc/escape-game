module Main where

import State.GameState (GameState, initialState)
import System.IO (hFlush, stdout)
import Core.CommandHandler (handleCommand)
import Core.CommandParser (parseCommand, tokenize)
import Core.Command (Command (Quit, InvalidLiteralCommand), helpCommandList, printHelp)
import Util.IO (printLines)

-- Game loop
gameLoop :: GameState -> IO ()
gameLoop state = do
    putStr "> "
    hFlush stdout
    userInput <- getLine

    print (tokenize (words userInput)) -- For debugging. Remove later.
    -- Parse user input into a command
    let command = parseCommand userInput

    print command -- For debugging. Remove later.

    case command of
      InvalidLiteralCommand -> do putStrLn "Invalid literal in command. Type \"help\" for help."
                                  gameLoop state
      Quit -> return ()
      _ -> do 
        newState <- handleCommand command state
        gameLoop newState

main :: IO ()
main = do
    putStrLn "Welcome to the game!"
    printHelp
    gameLoop initialState
