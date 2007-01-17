fromRoman ('M' : s) = 1000 + (fromRoman s)
fromRoman ('D' : s) = 500 + (fromRoman s)
fromRoman ('C' : 'M' : s) = 900 + (fromRoman s)
fromRoman ('C' : 'D' : s) = 400 + (fromRoman s)
fromRoman ('C' : s) = 100 + (fromRoman s)
fromRoman ('L' : s) = 50 + (fromRoman s)
fromRoman ('X' : 'C' : s) = 90 + (fromRoman s)
fromRoman ('X' : 'L' : s) = 40 + (fromRoman s)
fromRoman ('X' : s) = 10 + (fromRoman s)
fromRoman ('V' : s) = 5 + (fromRoman s)
fromRoman ('I' : 'X' : s) = 9 + (fromRoman s)
fromRoman ('I' : 'V' : s) = 4 + (fromRoman s)
fromRoman ('I' : s) = 1 + (fromRoman s)
fromRoman [] = 0

toRoman n = ((replicate n3 'M') ++
             (toRoman' n2 'C' 'D' 'M') ++ 
             (toRoman' n1 'X' 'L' 'C') ++ 
             (toRoman' n0 'I' 'V' 'X'))
    where toRoman' n' c1 c5 c10 | n' <= 3 = replicate n' c1
                                | n' == 4 = [c1, c5]
                                | n' == 5 = [c5]
                                | n' <= 8 = [c5] ++ (replicate (n' - 5) c1)
                                | n' == 9 = [c1, c10]
          n0 = n `mod` 10
          n1 = (n `div` 10) `mod` 10
          n2 = (n `div` 100) `mod` 10
          n3 = n `div` 1000

ans ll = sum $ map ans' ll
    where ans' l = l1 - l2
              where
                l1 = length l
                l2 = length $ toRoman $ fromRoman l

main = do
  d <- readFile "problem89_data.txt"
  print $ ans $ lines $ d