import Data.List

primes :: [Int]
primes = 2 : filter isPrime [3 ..]
isPrime n = not $ any (\p -> n `mod` p == 0) $ takeWhile (nSqrt >=) primes
  where nSqrt = (floor . sqrt . fromIntegral $ n)

divisors n = divisors' n primes
  where divisors' n pp@(p:ps) | n == 1 = []
                              | n < p = [n]
                              | n `mod` p == 0 = p:divisors' (n `div` p) pp
                              | otherwise = divisors' n ps
                                            
grpDivisors n = map (\ll -> (ll !! 0, length ll)) $ group $ divisors n

phi n = product $ map (\(n, m) -> (n-1)*(n^(m-1))) $ grpDivisors n

dd = map d' [1..1000000]
  where d' n = (n, (fromIntegral n)/(fromIntegral $ phi n))

res = maximumBy (\a b-> compare (snd a) (snd b)) dd

--main = putStrLn $ show res