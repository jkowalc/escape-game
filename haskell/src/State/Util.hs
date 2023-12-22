module State.Util where

import State.GameState (GameState(..), LockState(..))
import qualified Data.Map as Map
import Object.Place (Place(..))
import Data.Maybe (fromMaybe)

setRandomPasswords :: Int -> GameState -> GameState
setRandomPasswords seed state = do
    let vaultPassword = show seed
    let reverseSeed = 109999 - seed
    let digit0 = (reverseSeed - reverseSeed `mod` 10000) `div` 10000 
    let digit1 = (reverseSeed `mod` 10000 - reverseSeed `mod` 1000) `div` 1000
    let digit2 = (reverseSeed `mod` 1000 - reverseSeed `mod` 100) `div` 100
    let digit3 = (reverseSeed `mod` 100 - reverseSeed `mod` 10) `div` 10
    let digit4 = reverseSeed `mod` 10 `div` 1
    let tendigitPassword = show ((digit3 * 100) + digit4 + (digit2 * 10) + (digit0 * 10000) + (digit1 * 1000))
    let vL = LockState False vaultPassword
    let tenL = LockState False tendigitPassword
    let state1 = state { lockStates = Map.insert Vault vL (lockStates state) }
    state1 { lockStates = Map.insert Pad10Digit tenL (lockStates state1) }


getLockState :: Place -> GameState -> LockState
getLockState place state = 
    let maybeLockState = Map.lookup place (lockStates state)
    in fromMaybe (LockState False "error") maybeLockState