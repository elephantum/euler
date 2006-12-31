fact n | n == 1 = 1
       | otherwise = n * fact (n-1)

digits n | n >= 10 = (mod n 10):digits (div n 10)
         | otherwise = [n]