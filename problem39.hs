import Data.List
import Control.Parallel
import Control.Parallel.Strategies

isRightTriangle (a, b, c) = a*a + b*b == c*c

sides p = [(a, b, p - a - b) | a <- [1 .. p `div` 2], b <- [a+1 .. p-a-1], 
           a < p-a-b, b < p-a-b]

rightTriangles p = filter isRightTriangle $ sides p

triangles :: [(Int, Int)]
triangles = map (\p -> (p, length $ rightTriangles p)) [1..1000] `using` parListChunk 100 rdeepseq

res = fst $ maximumBy (\a b -> compare (snd a) (snd b)) $ triangles

main = putStrLn $ show res