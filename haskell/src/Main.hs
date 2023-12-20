module Main where

import State.GameState (GameState (currentPlace, randomSeed, lockStates), initialState, setRandomPasswords)
import System.Random
import System.IO (hFlush, stdout)
import Core.CommandHandler (handleCommand)
import Core.CommandParser (parseCommand, tokenize)
import Core.Command (Command (Quit, InvalidLiteralCommand), helpCommandList, printHelp)
import Util.IO (printLines)
import MapEventHandler.OnArrival (onArrival)
import Object.Lock (LockState(lockPassword))

-- Game loop
gameLoop :: GameState -> IO ()
gameLoop state = do
    putStr "> "
    hFlush stdout
    userInput <- getLine

    -- print (tokenize (words userInput)) -- For debugging. Remove later.
    -- print (tokenize (words userInput)) -- For debugging. Remove later.

    -- Parse user input into a command
    let command = parseCommand userInput

    -- print command -- For debugging. Remove later.

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
    onArrival (currentPlace initialState) initialState
    gen <- newStdGen
    let (randomNumber, newGen) = randomR (10000, 99999) gen :: (Int, StdGen)
    -- putStrLn $ "Random number: " ++ show randomNumber
    gameLoop (setRandomPasswords initialState randomNumber)
