{-
n = n/2 (even->any)
n = 3n + 1 (odd->even)
-}

{-
forward 1 = 1
forward n | mod n 2 == 0 = 1 + (forward $ div n 2)
          | otherwise = 1 + (forward $ 3*n+1)
-}

forward n = foldl (\a b->1+a) 0 $ forward' n
forward' n | mod n 2 == 0 = n:(forward' $ div n 2)
           | otherwise = n:(forward' $ 3*n+1)

cat = foldl (++) []

back = back'' [1]
    where
      back' n | mod n 2 == 0 && mod (n-1) 3 == 0 && n > 0= [div (n-1) 3, n*2]
              | otherwise = [n*2]
      back'' nn = nn':(back'' nn')
          where nn' = cat $ map back' nn

nth 1 l = head l
nth n l = nth (n-1) (tail l)

maxl p (l:ls) = maxl' p l ls
    where
      maxl' p v [] = v
      maxl' p v (l:ls) = maxl' p (max' p v l) ls
      max' p a b | (p a) > (p b) = a
                 | otherwise = b

main = putStrLn $ show $ (\x -> maxl snd (zip [1..x] (map forward [1..x]))) 100000