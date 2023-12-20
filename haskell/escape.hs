import System.IO

data Item = TeddyBear | SmallKey | Cheese |ScrewdriverBit|ScredriverHandle|Screwdriver
    deriving (Show, Eq)

data Place = MainRoom| Desk | Window| Chair | WoodenBox|Painting |Vent|OldDoor|Fireplace| Office|Computer|CoffeTable
    deriving (Show, Eq)

data SubPlace = TopDrawer|MidleDrawer|BottomDrawer|Nest|TornCorner|VentCover
    deriving (Show, Eq)

data GameState = GameState
    { inventory :: [Item]
    , currentPlace :: Place
    } deriving (Show)

path :: Place -> Place -> Bool
path place otherplace 
    |place == MainRoom && isIn otherplace [Desk, Window,Fireplace, Chair, OldDoor, WoodenBox,Painting]= True         
    |otherwise = False 

isIn p [] = False
isIn p (x:xs)
    | p==x=True
    | otherwise = isIn p xs

-- Initial game state
initialState :: GameState
initialState = GameState [] MainRoom

-- Commands
data Command = Look
    | Go Place
    | Examine
    | ExaminePlace Place
    | Take Item
    | Use Item
    | UseOn Item Place
    | Combine Item Item
    | EnterCode String Place
    | Help
    | Quit
    deriving (Show, Eq)

-- Function to handle user input and update game state
handleCommand :: GameState -> Command -> IO GameState
handleCommand state command =
    case command of
        Look -> do
            printGameState state
            return state

        Go destination -> do
            if path (currentPlace state) destination
                then do 
                    putStrLn $ "Going to " ++ show destination
                    return $ state { currentPlace = destination }
                else do
                     putStrLn $ "No valid path from " ++ show (currentPlace state) ++ " to " ++ show destination
                     return state

        Examine -> do
            putStrLn "Looking around..."
            -- Implement logic to examine the current place
            return state

        ExaminePlace place -> do
            putStrLn $ "Examining " ++ show place
            -- Implement logic to examine a specific place
            return state

        Take item -> do
            putStrLn $ "Taking " ++ show item
            return $ state { inventory = item : inventory state }

        Use item -> do
            putStrLn $ "Using " ++ show item
            -- Implement logic to use an item
            return state

        UseOn item place -> do
            putStrLn $ "Using " ++ show item ++ " on " ++ show place
            -- Implement logic to use an item on a place
            return state

        Combine item1 item2 -> do
            putStrLn $ "Combining " ++ show item1 ++ " with " ++ show item2
            -- Implement logic to combine items
            return state

        EnterCode code place -> do
            putStrLn $ "Entering code " ++ code ++ " at " ++ show place
            -- Implement logic to enter a code
            return state

        Help -> do
            printHelp
            return state

        Quit -> do
            putStrLn "Quitting the game. Goodbye!"
            return state

-- Function to print the game state
printGameState :: GameState -> IO ()
printGameState (GameState inv place) = do
    putStrLn $ "Current Place: " ++ show place
    putStrLn $ "Inventory: " ++ show inv

-- Function to print help instructions
printHelp :: IO ()
printHelp = do
    putStrLn "Commands:"
    putStrLn "look                     - Look around"
    putStrLn "go <place>               - Go to a place"
    putStrLn "examine                  - Examine the current place"
    putStrLn "examine <place>          - Examine a specific place"
    putStrLn "take <item>              - Take an item"
    putStrLn "use <item>               - Use an item"
    putStrLn "use <item> on <place>    - Use an item on a place"
    putStrLn "combine <item1> <item2> - Combine two items"
    putStrLn "enter_code <code> <place>- Enter a code or password to a lock"
    putStrLn "inventory                - List contents of your inventory"
    putStrLn "help                     - Display these instructions again"
    putStrLn "quit                     - Quit the game"

main :: IO ()
main = do
    putStrLn "Welcome to the Adventure Game!"
    putStrLn "Type 'help' for instructions."

    -- Start the game loop with the initial state
    gameLoop initialState

-- Game loop
gameLoop :: GameState -> IO ()
gameLoop state = do
    putStr "> "
    hFlush stdout
    userInput <- getLine

    -- Parse user input into a command
    let command = parseCommand userInput

    -- Handle the command and get the updated game state
    newState <- handleCommand state command

    -- If the Quit command is received, end the game loop
    if command == Quit
        then putStrLn "Game Over!"
        else gameLoop newState

-- Function to parse user input into a command
parseCommand :: String -> Command
parseCommand input = case words input of
    ["look"] -> Look
    ["go", place] -> Go (read place)
    ["examine"] -> Examine
    ["examine", place] -> ExaminePlace (read place)
    ["take", item] -> Take (read item)
    ["use", item] -> Use (read item)
    ["use", item, "on", place] -> UseOn (read item) (read place)
    ["combine", item1, item2] -> Combine (read item1) (read item2)
    ["enter_code", code, place] -> EnterCode code (read place)
    ["inventory"] -> Examine
    ["help"] -> Help
    ["quit"] -> Quit
    _ -> Help  -- Display help for invalid commands

-- Instances to enable reading for custom data types
instance Read Item where
    readsPrec _ "TeddyBear" = [(TeddyBear, "")]
    readsPrec _ "SmallKey"  = [(SmallKey, "")]
    readsPrec _ "Cheese"    = [(Cheese, "")]
    readsPrec _ _           = []

instance Read Place where
    readsPrec _ "MainRoom"  = [(MainRoom, "")]
    readsPrec _ "Desk"      = [(Desk, "")]
    readsPrec _ "TornCorner"= [(TornCorner, "")]
    readsPrec _ "Nest"      = [(Nest, "")]
    readsPrec _ _           = []
