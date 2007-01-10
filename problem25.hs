add a [] = a
add [] b = b
add aa@(a:at) bb@(b:bt) = if ab < 10 then ab:(add at bt)
                                     else (ab `mod` 10):(add at (add bt [1]))
    where ab = a+b

fib = [1]: [1]: fib' [1] [1]
    where fib' a b = (ab):fib' b (ab)
              where ab = a `add` b

main = print $ fst $ head $ dropWhile ((1000 >) . length . snd) $ zip [1..] fib

