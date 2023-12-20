module Object.Lock where

data LockState = LockState
    {   
        name :: String
        ,isOpen :: Bool
        ,lockPassword :: String
    }
lockNames :: [String]
lockNames = ["10PadDigit", "Vault", "Computer", "ColorCode"]