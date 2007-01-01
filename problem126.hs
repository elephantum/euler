s a b c n = 4*n*n + (2*c + 4*(n-1))*(a+b-2) + 4*n*c - 4*(n-1)

allCubes = foldr (++) [] (map gen_abc [1..])
    where gen_bc a = foldr (++) [] (map (gen_c a) [1..a])
          gen_c a b = map (\c->(a, b, c)) [1..b]

takeWhile