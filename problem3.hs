divisors' 1 _ = [1]
divisors' n pp@(p:ps) | mod n p == 0 = [p] ++ divisors' (div n p) pp
                      | otherwise = divisors' n ps

primes_gen = primes_gen' 2 []
    where
      --primes_gen' i [] = i:primes_gen' 
      primes_gen' i pp | any (\p->mod i p == 0) pp = primes_gen' (i+1) pp
                       | otherwise = i:(primes_gen' (i+1) (pp++[i]))

maxl (l:ls) = maxl' l ls
    where
      maxl' v [] = v
      maxl' v (l:ls) = maxl' (max v l) ls

main = putStrLn $ show $ maxl $ divisors' 317584931803 primes_gen