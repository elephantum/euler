fac n = foldr (*) 1 [2..n]
c n k = (fac n) `div` ((fac k) * (fac (n-k)))

res = length [(n,k) | n <- [1..100], k <- [1..n-1], (c n k > 1000000)]