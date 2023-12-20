module Lock where
import Data.Bool

data LockState = Locked
                | Opened deriving (Enum, Eq)

-- class Code a where
--     enterCode :: a -> String -> String
--     isOpen :: a -> Boolean
--     doOpened :: a -> String

data Lock = Lock{
    lockState_ :: LockState,
    code :: String 
}


isOpen :: Lock -> Bool
isOpen currLock
        | (lockState_ currLock) == Locked              = False
        | otherwise                                 = True
tryToOpen :: Lock -> String -> String
tryToOpen currLock userCode = do
    if (isOpen currLock) == True then "Lock already opened!"
        else if userCode == (code currLock) then doOpened' currLock
            else "Wrong Code!"

doOpened' :: Lock -> String
doOpened' myLock = do
    (lockState_ myLock) = Opened
    "Opened"






-- instance Lock Code where{
--     isOpen  | lockState_ == Locked              = False
--             | otherwise                         = True
--     enterCode userCode = do
--         if isOpen then "Lock already opened!"
--         else if userCode == code then doOpened
--             else "Wrong Code!"
-- }

main :: IO()
main = do

    let myLock = Lock Locked "6524"
    putStrLn $ "isOpen: " ++ show(isOpen myLock)
    putStrLn $ "enterCode: " ++ tryToOpen myLock "1223"
    putStrLn $ "enterCode: " ++ tryToOpen myLock "6524"
    putStrLn $ "enterCode: " ++ tryToOpen myLock "6524"


-- enterCode :: Lock -> string -> string
-- enterCode lock code = do
--     case elem a current_pos.paths of
--         1 -> do setOpen
--     case a of