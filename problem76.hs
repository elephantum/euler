divs n = (divs' n 1) - 1

divs' n k | n == k = 1
          | n > k = (divs' (n-k) k) + (divs' n (k+1))
          | n < k = 0

main = putStrLn $ show $ divs 100