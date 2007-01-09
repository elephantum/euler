trunc n = n `mod` 10000000000

nn n = foldr (\a b -> trunc $ a * b) 1 [n|i<-[1..n]]