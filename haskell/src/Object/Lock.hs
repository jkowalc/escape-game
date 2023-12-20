module Object.Lock where
import Object.Place (Place)

data LockState = LockState
    {   
        subPlace :: Place
        ,isOpen :: Bool
        ,lockPassword :: String
    }
lockNames :: [String]
lockNames = ["Pad10Digit", "Vault", "ComputerPassword", "ColorCode"]