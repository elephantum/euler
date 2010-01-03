weekdays = [1 .. 7] ++ weekdays

feb y | y `mod` 400 == 0 = 29
      | y `mod` 100 == 0 = 28
      | y `mod` 4 == 0 = 29
      | otherwise = 28

year n = [31, feb n, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]

century = concat $ map year [1900 .. 2000]

start_days _ [] = []
start_days d (m:ms) = d : start_days (mod (m+d) 7) ms

start_sundays = length $ filter (6 ==) $ drop 12 $ start_days 0 century

main = putStrLn $ show start_sundays