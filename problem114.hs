import qualified Data.Map as Map
import Control.Monad.State

data Colored a = Red a | Black a deriving (Eq, Show)

instance (Ord a) => Ord (Colored a) where
    compare (Red a)   (Red b)   = compare a b
    compare (Black a) (Black b) = compare a b
    compare (Red _)   (Black _) = LT
    compare (Black _) (Red _)   = GT

type Cache = Map.Map (Colored Integer) Integer

emptyCache :: Cache
emptyCache = Map.empty

{- cachePut :: (Colored Integer) -> Integer -> StateTrans Cache ()
cachePut k v = ST(\m->(insert k v m, ()))

cacheGet :: (Colored Integer) -> StateTrans Cache (Maybe Integer)
cacheGet k = ST(\m->(m, -}

cache computor key = do c <- get
                        case ((\x -> Map.lookup x c) =<< Just key) of
                          Nothing -> do
                            val <- computor key
                            c' <- get
                            put (Map.insert key val c')
                            return val
                          Just val -> do
                            return val

divs' p = cache divs'' p

divs'' (Red n) | n < 3  = return 0
               | n == 3 = return 1
               | n > 3  = do vals <- mapM (\x -> divs' (Black $ n-x)) [3..n-1]
                             return $ 1 + (sum vals)

divs'' (Black n) | n == 0 = return 0
                 | n == 1 = return 1
                 | n > 1  = do vals <- mapM (\x -> divs' (Red $ n-x)) [1..n-1]
                               return $ 1 + (sum vals)

divs n = runState (do r <- divs' (Red n)
                      b <- divs' (Black n)
                      return $ r + b) emptyCache

{-
divs n = (red n) + (black n)
    where
      red n | n < 3 = 0
            | n == 3 = 1
            | n > 3 = 1 + (sum $ map (\x->black (n-x)) [3..n-1])
      black n | n == 0 = 0
              | n == 1 = 1
              | n > 1 = 1 + (sum $ map (\x->red (n-x)) [1..n-1])
-}

-- main = putStrLn $ show $ divs 50