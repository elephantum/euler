import qualified Data.Map as Map

-- number of cubes -> count
type Cache = Map.Map Integer Integer

emptyCache :: Cache
emptyCache = Map.empty

s a b c n = 4*n*n + (2*c + 4*(n-1))*(a+b-2) + 4*n*c - 4*(n-1)

cat = foldr1 (++)

cubes = cat $ map gen_bc [1..]
    where gen_bc a = cat $ map (gen_c a) [1..a]
          gen_c a b = map (\c->(a, b, c)) [1..b]

cubesAndLayers = cat $ map (cubesAndLayers' cubes) [1..]
    where cubesAndLayers' _ 0 = []
          cubesAndLayers' ((a,b,c):cs) l = (a,b,c,l):(cubesAndLayers' cs (l-1))

-- list of computed (number of cubes, count)
countCubes :: [(Integer, Integer)]
countCubes = countCubes' emptyCache cubesAndLayers
    where countCubes' cache ((a,b,c,n):cs) = (num, count):(countCubes' cache' cs)
              where
                num = s a b c n
                count = (Map.findWithDefault 0 num cache) + 1
                cache' = Map.insert num count cache

problem n = fst $ head $ dropWhile ((n /=) . snd) countCubes

progress ll = progress' 1 ll
    where progress' n ll = do
            ll' <- return $ dropWhile ((n /=) . snd) ll
            putStrLn  (show $ head ll')
            progress' (n+1) ll'

main = progress countCubes