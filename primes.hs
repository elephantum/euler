module Primes where

divisible b a = mod a b == 0

divisors n = divisors' n primes_gen
    where
      divisors' _ [] = []
      divisors' n pp@(p:ps) | divisible p n = [p] ++ divisors' (div n p) pp
                            | otherwise = divisors' n ps

cum_divisors nn = cum_divisors' nn primes_gen
    where
      cum_divisors' nn [] = []
      cum_divisors' nn pp@(p:ps) | any (divisible p) nn = p:cum_divisors' (div' nn p) pp
                                 | otherwise = cum_divisors' nn ps
      div' nn p = map (div_if_divisible p) nn
      div_if_divisible p n | divisible p n = div n p
                           | otherwise = n


primes_gen = primes_gen' [2..] []
    where
      primes_gen' (i:is) pp | any (\p->mod i p == 0) pp' = primes_gen' is pp
                            | otherwise = i:(primes_gen' is (pp ++ [i]))
          where pp' = takeWhile (sq_i >=) pp
                sq_i = (floor $ sqrt $ fromInteger i) + 1

