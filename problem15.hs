import Data.Array

dec aa bb = concat $ map (dec' aa) bb
    where dec' aa b = map (\x->(x, b)) aa

size = 21

grid = listArray ((1,1), (size, size)) $ map path $ dec [1..size] [1..size]

path (x,y) | x == size && y == size = 0
           | x == size = 1
           | y == size = 1
           | otherwise = (grid ! (x+1, y)) + (grid ! (x, y+1))

ans = grid ! (1,1)