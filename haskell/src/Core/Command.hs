module Core.Command where

import Object.Item (Item)
import Object.Place (Place)

printHelp :: IO ()
printHelp = do
    putStrLn "Commands:"
    mapM_ putStrLn helpCommandList

helpCommandList :: [String]
helpCommandList = [
    "look                     - Look around",
    "go <place>               - Go to a place",
    "examine                  - Examine the current place",
    "examine <place>          - Examine a specific place or item",
    "take <item>              - Take an item",
    "drop <item>              - Drop an item",
    "use <item>               - Use an item",
    "use <item> on <place>    - Use an item on a place or item",
    "combine <item1> with <item2> - Combine two items",
    "enter <code> into <place>- Enter a code or password to a lock",
    "inventory                - List contents of your inventory",
    "help                     - Display these instructions again",
    "quit                     - Quit the game"
    ]

data Command = Look
    | Go Place
    | Examine
    | ExaminePlace Place
    | ExamineItem Item
    | Take Item
    | Drop Item
    | Use Item
    | UseOnPlace Item Place
    | UseOnItem Item Item
    | Combine Item Item
    | EnterCode String Place
    | Inventory
    | Help
    | Quit
    | InvalidLiteralCommand
    deriving (Show, Eq)