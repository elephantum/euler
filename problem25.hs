fib a b = (a+b):fib b (a+b)
log10 n = log n / log 10

main = putStrLn $ show $ head $ filter (\x->log10 x > 2) $ fib 1 1