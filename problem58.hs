primes :: [Int]
primes = 2 : filter isPrime [3 ..]
isPrime n = not $ any (\p -> n `mod` p == 0) $ takeWhile (nSqrt >=) primes
  where nSqrt = (floor . sqrt . fromIntegral $ n)

dd = dd' 3 3 where
  dd' r a = [a, a+r-1, a+2*(r-1),  a+3*(r-1)] : dd' (r+2) (a + 3*(r-1) + r+1)

primesK nn = map (\x -> if isPrime x then 1 else 0) nn
                                               
group4 [] = []
group4 (a:b:c:d:tt) = a+b+c+d:group4 tt

acc tt = acc' 0 tt where
  acc' _ [] = []
  acc' a (v:vs) = a+v:acc' (a+v) vs

primesOnDiag = 0:(acc $ group4 $ primesK $ concat dd)

diag = zip [1..] (tail $ zip primesOnDiag (acc $ 1:cycle [4]))

res = head $ dropWhile (\(r, (a,b))-> a*10 > b) diag

main = putStrLn $ show $ res