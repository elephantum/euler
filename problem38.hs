import Data.List

digitize 0 = []
digitize n = (digitize $ n `div` 10) ++ [n `mod` 10]

makeConcatenatedProduct n = make 1 9
  where make m left | left > 0 = let nm = digitize (n*m) 
                                 in nm ++ make (m+1) (left - length nm)
                    | otherwise = []
                                  
isPandigital nn | length nn /= 9 = False
                | otherwise = (sort nn) == [1..9]

countdown 1 = []
countdown n = n : (countdown $ n-1)

res = head $ filter isPandigital $ map makeConcatenatedProduct $ countdown 99999

main = putStrLn $ concat $ map show res