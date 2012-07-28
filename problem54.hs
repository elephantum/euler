import Text.ParserCombinators.ReadP



-- 5H 5C 6S 7S KD
card = do
  v <- satisfy (\c -> elem c ['2', '3', '4', '5', '6', '7', '8', '9', 'J', 'Q', 'K', 'A'])
  s <- satisfy (\c -> 