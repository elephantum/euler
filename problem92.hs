import Data.Array

digitize 0 = []
digitize n = (mod n 10) : (digitize $ div n 10)

nchain' 1 = 1
nchain' 89 = 89
nchain' n = nchain $ sum [i*i | i <- digitize(n)]

-- cache lower values, 4 times speed improvement
nchainCache = array (1, 600) [(i, nchain' i) | i <- [1..600]]

nchain n | n < 600 = nchainCache ! n
         | otherwise = nchain' n
                                  
main = putStrLn $ show $ length [i | i <- [1..10000000-1], nchain i == 89]
