primes_gen = primes_gen' 2 []
    where
      --primes_gen' i [] = i:primes_gen' 
      primes_gen' i pp | any (\p->mod i p == 0) pp = primes_gen' (i+1) pp
                       | otherwise = i:(primes_gen' (i+1) (i:pp))

getwhile _ [] = []
getwhile p (l:ls) | p l = l : getwhile p ls
                  | otherwise = []

main = putStrLn $ show $ sum $ getwhile (\x->x<1000000) primes_gen