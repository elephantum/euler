import Data.List

primes :: [Int]
primes = 2 : filter isPrime [3 ..]
isPrime n = all (\p -> n `mod` p /= 0) $ takeWhile ((floor . sqrt . fromIntegral $ n) >=) primes

toNumber = foldr (\d a -> a*10 + d) 0

pandigitals = concat $ map (\n -> map toNumber $ permutations [1..n]) [2..9]

primePandigitals = filter isPrime pandigitals

res = maximum primePandigitals