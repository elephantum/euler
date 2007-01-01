import Data.Array
import Data.List

next n
    | even n    = n `div` 2
    | otherwise = 3*n+1

upper_bound = 1000000
chain_lengths = listArray (1, upper_bound) $ map chain_length [1..]

chain_length 1 = 1
chain_length n = 1 + len_next
    where n' = next n
          len_next = if n' < upper_bound then chain_lengths!n'
                                         else chain_length n'

(max_index, max_len) = maximumBy (\(_,x) (_,y) -> compare x y) $ assocs chain_lengths

chain 1 = [1]
chain n = n:(chain $ next n)

main = do putStrLn $! "max index: " ++ (show max_index)
          putStrLn $ "max chain length: " ++ (show max_len)
          putStrLn "max chain:"
          print $ chain max_index