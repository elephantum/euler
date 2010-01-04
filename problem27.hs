import qualified Data.IntSet as IntSet

divisible b a = mod a b == 0

divisors n = divisors' n primesGen
    where
      divisors' _ [] = []
      divisors' n pp@(p:ps) | divisible p n = p : divisors' (div n p) pp
                            | otherwise = divisors' n ps

primesGen = primesGen' [2..] []
    where
      primesGen' (i:is) pp | any (\p->mod i p == 0) pp' = primesGen' is pp
                            | otherwise = i:(primesGen' is (pp ++ [i]))
          where pp' = takeWhile (sq_i >=) pp
                sq_i = (floor $ sqrt $ fromInteger i) + 1

poly a b = map (\x -> x*x + a*x + b) [0..]
                                          
primesSet = IntSet.fromDistinctAscList $ map (fromInteger :: Integer -> Int) $ takeWhile (87400>) primesGen

countConsecutivePrimes nn = length $ takeWhile (\x -> IntSet.member x primesSet) nn
                                          
consecutivePrimes = [(a*b, countConsecutivePrimes $ poly a b) | a <- [-1000 .. 1000], b <- [1 .. 1000]]

consecutivePrimes' = filter ((1<) . snd) consecutivePrimes

max' aa = foldl (\(pa, a) (pb, b) -> if a < b then (pb, b) else (pa, a)) (0, 0) aa

result = max' consecutivePrimes'