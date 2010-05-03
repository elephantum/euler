import Text.ParserCombinators.ReadP
import Data.Array

intParser :: ReadP Integer
intParser = do
  s <- munch1 (\c -> c >= '0' && c <= '9')
  return $ (read s :: Integer)

dataParser :: ReadP [[Integer]]
dataParser = endBy (sepBy intParser $ string ",") $ string "\r\n"

lastOne (a:[]) = a
lastOne (a:as) = lastOne as

plainify :: [[Integer]] -> [((Integer, Integer), Integer)]
plainify dd = concat $ indexX 0 dd
  where indexX _ [] = []
        indexX x (d:ds) = (indexY x 0 d):indexX (x+1) ds
        indexY _ _ [] = []
        indexY x y (d:ds) = ((x, y), d):indexY x (y+1) ds

buildArray maxIdx dd = arr
  where
    arr = array ((0,0), maxIdx) $ map buildArrayCell dd
    buildArrayCell ((x, y), v) = ((x, y), v + mn (opt (x-1) y) (opt x (y-1)))
    opt x y | x >= 0 && y >= 0 = Just $ arr ! (x, y)
            | otherwise = Nothing
    mn (Just a) (Just b) = min a b
    mn (Just a) Nothing = a
    mn Nothing (Just b) = b
    mn _ _ = 0

res dd = (buildArray (79,79)$ plainify dd) ! (79,79)

main = do
  s <- readFile "problem81_data.txt"
  d <- return $ fst $ lastOne $ readP_to_S dataParser s
  putStrLn $ show $ res d