gen_triples s = gen_triples' 3 (s-3)
    where
      gen_triples' s c | c>0 = (gen_triples'' 1 (s-1) c) ++ gen_triples' (s+1) (c-1)
                       | otherwise = []
      gen_triples'' a b c | b>0 = (a, b, c) : gen_triples'' (a+1) (b-1) c
                          | otherwise = []

pythagorean (a,b,c) | (a<b) && (b<c) = a*a + b*b == c*c
                    | otherwise = False

main = putStrLn $ show (a*b*c)
    where (a,b,c) = head $ filter pythagorean $ gen_triples 1000