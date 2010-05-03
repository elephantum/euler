{-

xn+1 = 1 + 1/(1 + xn)

xn=a/b
1+xn=(a+b)/b
1/(1+xn)=b/(a+b)
1+1/(1+xn)=(a+2b)/(a+b)

-}

fracs = fracs' 1 1
  where fracs' a b = (a,b) : fracs' (a+2*b) (a+b)
        
ndigits n = length $ show n

main = putStrLn $ show $ length $ filter (\(a,b) -> (ndigits a) > (ndigits b)) $ take 1000 fracs