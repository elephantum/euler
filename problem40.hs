import Data.List

digitize 0 = []
digitize n = (digitize $ n `div` 10) ++ [n `mod` 10]

fraction = concat (map digitize [1..])

res = foldr (*) 1 $ map ((fraction !!) . (flip (-) 1)) [1, 10, 100, 1000, 10000, 100000, 1000000]