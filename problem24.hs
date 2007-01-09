import Data.List

fac n = foldr (*) 1 [2..n]

permutation 0 [o] = [o]
permutation n oo = o:(permutation n' oo')
    where o = oo !! i
          cluster = fac $ (length oo) - 1
          i = n `div` cluster
          n' = n - (cluster * i)
          oo' = delete o oo

main = print $ permutation 999999 [0..9]
-- main = print $ head $ filter (\((na, a):(nb, b):_)-> a> b) $ tails $ map (\n->(n, permutation n [0..9])) [0..((fac 10) - 1)]