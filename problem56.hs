let digits n = if n > 0 then (n `mod` 10) : (digits $ n `div` 10) else []
let sum_digits n = sum $ digits n
maximum [sum_digits $ pow a b | a <- [1..100], b <- [1..100]]