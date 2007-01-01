norm n = n `mod` 10000000000

pow2 1 = 2
pow2 n | even n = norm $ (\x->x*x) (pow2 (n `div` 2))
       | otherwise = norm $ 2 * (pow2 (n-1))

main = print $ norm $ 28433 * (pow2 7830457) + 1