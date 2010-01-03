import List
import qualified Data.Set as Set

divisible b a = mod a b == 0

-- простые делители числа n
divisors n = divisors' n primesGen
    where
      divisors' _ [] = []
      divisors' n pp@(p:ps) | n < p = []
                            | divisible p n = p : divisors' (div n p) pp
                            | otherwise = divisors' n ps

-- генератор простых чисел
primesGen = primesGen' [2..] []
    where
      primesGen' (i:is) pp | any (\p->mod i p == 0) pp' = primesGen' is pp
                            | otherwise = i:(primesGen' is (pp ++ [i]))
          where pp' = takeWhile (sq_i >=) pp
                sq_i = (floor $ sqrt $ fromInteger i) + 1

uniqify = map head . group . sort

-- сложные делители i.e. 28 == 1, 2, 4, 7, 14
properDivisors n = uniqify $ 1:(combinate 1 $ divisors n)
  where
    combinate _ [] = []
    combinate m dd@(d:ds) = [m*i | i <- dd] ++ combinate m ds ++ combinate (m*d) ds

isAbundant n = (2*n) < (sum $ properDivisors n)

abundantInRange n = filter isAbundant [1 .. n]

interestingLimit = 28123

interestingAbundant = abundantInRange interestingLimit

sumsOfTwo nn = Set.fromList $ sums nn
  where
    sums [] = []
    sums aa@(a:as) = (map (a+) aa) ++ (sums as)

interestingSums = sumsOfTwo interestingAbundant
                                                                                  
result = sum $ Set.toList $ Set.difference (Set.fromDistinctAscList [1 .. interestingLimit]) interestingSums

-- main = putStr $ show result