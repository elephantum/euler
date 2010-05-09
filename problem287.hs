import Control.Monad.Writer.Lazy

data Color = Black | White deriving (Show, Eq)

type Region = ((Integer, Integer), Integer)

type Encoder = Region -> (Integer, Bool)

walkOrder = [(0, 0), (0, 1), (1, 0), (1, 1)]

descendRegion liftVal f r =
  let (val, cont) = f r
  in val `seq` cont `seq` do 
    tell $ liftVal val
    if cont then reallyDescend liftVal f r
      else return ()     

reallyDescend liftVal f r@((x, y), s) = 
  let 
    subRegions = [((x + dx*s', y + dy*s'), s') | (dx, dy) <- walkOrder]
    s' = s `div` 2
  in 
   subRegions `seq` mapM_ (descendRegion liftVal f) subRegions

fill n = \x y -> if (x - v2n1)^2 + (y - v2n1)^2 <= v22n2 then Black else White
  where 
    v2n = 2^n
    v2n1 = 2^(n-1)
    v22n2 = 2^(2*n - 2)

                     

checkOrder = [(0, 0), (1, 0), (0, 1), (1, 1)]


encode :: Integer -> (Integer -> Integer -> Bool) -> Region -> (Integer, Bool)
encode n = encode'
  where 
    v2n = 2^n
    encode' f r@(p,s) = if s /= v2n then 
                          case sameColor f r of
                            Just Black -> ([1,1], False)
                            Just White -> ([1,0], False)
                            Nothing -> ([0], True)
                        else ([0], True)


sameColor f ((x, y), s) = if (s > 1) && (all (head cc ==) $ tail cc) then Just $ head cc
                          else Nothing
                            where        
                              aa = [(x + dx*(s - 1), y + dy*(s - 1)) | (dx, dy) <- checkOrder]
                              cc = [f x y | (x, y) <- aa]

n = 4

-- res = 1 + (getSum $ snd $ runWriter (descendRegion Sum (encode fill) ((0,0), v2n)))
res = snd $ runWriter (descendRegion (:[]) (encode $ fill n) ((0,0), 2^n))

main = putStrLn $ show res

-- 313295509
-- 313135497
