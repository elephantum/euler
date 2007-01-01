import Data.Array
import Control.Monad.State

{-
n = n/2 (even->any)
n = 3n + 1 (odd->even)
-}

type Cache = Array Integer Integer

emptyCache :: Integer -> Cache
emptyCache n = array (1, n) []

cache computor key = do c <- get
                        val <- return $ c ! key
                        if val > 0 then return val
                                   else
                                       do val' <- computor key
                                          c' <- get
                                          put (c' // [(key, val')])
                                          return val'

forward n = cache forward' n

forward' n | n == 1 = return 1
           | even n = do next_len <- forward $ div n 2
                         return $ 1 + next_len
           | otherwise = do next_len <- forward $ 3*n+1
                            return $ 1 + next_len

maxl p (l:ls) = maxl' p l ls
    where
      maxl' p v [] = v
      maxl' p v (l:ls) = maxl' p (max' p v l) ls
      max' p a b | (p a) > (p b) = a
                 | otherwise = b

problem n = maxl snd (zip [1..n] (fst $ runState (mapM forward [1..n]) (emptyCache n)))

main = putStrLn $ show $ problem 1000000