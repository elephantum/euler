import qualified Data.IntMap as IntMap

toDecimal n = toDecimal' n 1
  where
    toDecimal' _ 0 = []
    toDecimal' den num = (mod num den) : (toDecimal' den $ (mod num den)*10)

findCycle nums = findCycle' (IntMap.empty) nums 0
  where findCycle' _ [] _ = 0
        findCycle' numMap (n:ns) pos =
          case IntMap.lookup n numMap of
            Just prevPos -> pos - prevPos
            Nothing -> findCycle' (IntMap.insert n pos numMap) ns (pos+1)
            
result = fst $ maximumBy (\(_, a) (_, b) -> compare a b) $ map (\x -> (x, findCycle $ toDecimal x)) [1..1000]