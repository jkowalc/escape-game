module Core.CommandParser where

import Core.Command (Command(..))
import Object.Place (Place)
import Object.Item (Item)

keywordList :: [String]
keywordList = ["look", "go", "examine", "take", "use", "combine", "enter", "help", "quit", "inventory", "drop", "on", "with", "into"]

data Token = Keyword String
    | Literal String
    deriving (Show, Eq)

-- Function to check if a string is a keyword
isKeyword :: String -> Bool
isKeyword s = s `elem` keywordList

-- Function to tokenize a list of strings
tokenize :: [String] -> [Token]
tokenize [] = []
tokenize input = go [] input
  where
    go :: [String] -> [String] -> [Token]
    go [] [] = []
    go acc [] = [createToken acc]
    go acc (y:ys)
      | isKeyword y && null acc = Keyword y : go [] ys
      | isKeyword y = createToken acc : Keyword y : go [] ys
      | otherwise = go (acc ++ [y]) ys

    createToken :: [String] -> Token
    createToken strings = Literal (unwords strings)
  

parseExamineThing :: Token -> Command
parseExamineThing (Literal thingStr) = 
  -- try reading the thing as a place
  case reads thingStr :: [(Place, String)] of
    [(place, "")] -> ExaminePlace place
    _ -> 
      -- try reading the thing as an item
      case reads thingStr :: [(Item, String)] of
        [(item, "")] -> ExamineItem item
        _ -> InvalidLiteralCommand  -- Display help for invalid command

parseUseOnThing :: Item -> Token -> Command
parseUseOnThing firstItem (Literal thingStr) = 
  -- try reading the thing as a place
  case reads thingStr :: [(Place, String)] of
    [(place, "")] -> UseOnPlace firstItem place
    _ -> 
      -- try reading the thing as an item
      case reads thingStr :: [(Item, String)] of
        [(item, "")] -> UseOnItem firstItem item
        _ -> InvalidLiteralCommand  -- Display help for invalid command

parseCommand :: String -> Command
parseCommand input = case tokenize (words input) of
    [Keyword "look"] -> Look
    [Keyword "go", Literal placeStr] -> if null (reads placeStr :: [(Place, String)])
      then InvalidLiteralCommand
      else Go (read placeStr)
    [Keyword "examine"] -> Examine
    [Keyword "examine", Literal thingStr] -> parseExamineThing (Literal thingStr)
    [Keyword "take", Literal itemStr] -> if null (reads itemStr :: [(Item, String)])
      then InvalidLiteralCommand
      else Take (read itemStr)
    [Keyword "drop", Literal itemStr] -> if null (reads itemStr :: [(Item, String)])
      then InvalidLiteralCommand
      else Drop (read itemStr)
    [Keyword "use", Literal itemStr] -> if null (reads itemStr :: [(Item, String)])
      then InvalidLiteralCommand
      else Use (read itemStr)
    [Keyword "use", Literal itemStr, Keyword "on", Literal thingStr] -> if null (reads itemStr :: [(Item, String)])
      then InvalidLiteralCommand
      else parseUseOnThing (read itemStr) (Literal thingStr)
    [Keyword "combine", Literal item1Str, Keyword "with", Literal item2Str] -> if null (reads item1Str :: [(Item, String)]) || null (reads item2Str :: [(Item, String)])
      then InvalidLiteralCommand
      else Combine (read item1Str) (read item2Str)
    [Keyword "enter", Literal code, Keyword "into", Literal placeStr] -> if null (reads placeStr :: [(Place, String)])
      then InvalidLiteralCommand
      else EnterCode code (read placeStr)
    [Keyword "inventory"] -> Inventory
    [Keyword "help"] -> Help
    [Keyword "quit"] -> Quit
    _ -> Help  -- Display help for invalid commands
