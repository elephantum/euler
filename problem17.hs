numberToString :: Int -> [String]

numberToString 0 = []
numberToString 1 = ["one"]
numberToString 2 = ["two"]
numberToString 3 = ["three"]
numberToString 4 = ["four"]
numberToString 5 = ["five"]
numberToString 6 = ["six"]
numberToString 7 = ["seven"]
numberToString 8 = ["eight"]
numberToString 9 = ["nine"]
numberToString 10 = ["ten"]
numberToString 11 = ["eleven"]
numberToString 12 = ["twelve"]
numberToString n | n < 20 = [teen n ++ "teen"]
numberToString n | n < 100 = [tens (div n 10)] ++ numberToString (mod n 10)
numberToString n | n < 1000 = numberToString (div n 100) ++ ["hundred"] ++ 
                              if rest > 0 then ["and"] ++ numberToString rest
                              else []
                                  where rest = mod n 100 
numberToString 1000 = ["one", "thousand"]

teen 13 = "thir"
teen 14 = "four"
teen 15 = "fif"
teen 16 = "six"
teen 17 = "seven"
teen 18 = "eigh"
teen 19 = "nine"

tens 2 = "twenty"
tens 3 = "thirty"
tens 4 = "forty"
tens 5 = "fifty"
tens 6 = "sixty"
tens 7 = "seventy"
tens 8 = "eighty"
tens 9 = "ninety"

letters l = sum (map length l)

-- sum $ map (letters . numberToString) [1..1000]