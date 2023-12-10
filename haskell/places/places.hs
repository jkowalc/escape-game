-- Define the Place class
class Place a where
    getName :: a -> String
    getDescription :: a -> String
    getDetails :: a -> String
    getPaths :: a -> [a]
    addPath :: a -> a-> a

-- Define a data type representing a location
data Location = Location
    { locationName :: String,
    desctiption :: String,
    details :: String,
    paths :: [Location] 
    }

-- Make Location an instance of the Place class
instance Place Location where
    getName = locationName
    getDescription = desctiption
    getDetails = details
    addPath place newPath = place {paths = newPath : paths place}


-- Example usage
main :: IO ()
main = do
    let place = Location "Example Place" "desc" "detail" []
    let otherPlace = Location "Other Place" "desc 2" "detail 2" [place]

    
    putStrLn $ "Name: " ++ getName place
    putStrLn $ "Desc: " ++ show (getDescription place)
    putStrLn $ "Details: " ++ show (getDetails place)
    putStrLn $ "Paths: " ++ show (getPaths place)

    putStrLn $ "Name: " ++ getName otherPlace
    putStrLn $ "Desc: " ++ show (getDescription otherPlace)
    putStrLn $ "Details: " ++ show (getDetails otherPlace)
    putStrLn $ "Paths: " ++ show (getPaths otherPlace)

