# -*- coding: utf-8 -*-

import itertools
from problem33 import primes, num_to_list, list_to_num

def find_bisect(n, arr, a, b):
  if b - a == 0: return False

  if arr[a] == n or arr[b-1] == n: return True

  if n < arr[a] or n > arr[b-1]: return False

  middle = (b-a) / 2 + a
  if arr[middle] == n:
    return True
  elif arr[middle] > n:
    return find_bisect(n, arr, a, middle)
  else:
    return find_bisect(n, arr, middle+1, b)

def is_prime(n):
  while len(primes.known_primes) == 0 or primes.known_primes[-1] < n:
    primes.next()
    
  return find_bisect(n, primes.known_primes, 0, len(primes.known_primes))

def tails(l):
  for i in range(1, len(l)):
    yield l[:-i]

def heads(l):
  for i in range(1, len(l)):
    yield l[i:]

def is_trunkable_right(n):
  nn = list(num_to_list(n))

  for t in heads(nn):
    if not is_prime(list_to_num(t)):
      return False

  return True

def is_trunkable_left(n):
  nn = list(num_to_list(n))

  for t in tails(nn):
    if not is_prime(list_to_num(t)):
      return False

  return True

def is_interesting(n):
  if n < 10: return False

  return is_trunkable_right(n) and is_trunkable_left(n)

def gen_interesting():
  cur = [2, 3, 5, 7]
  next = []

  while True and cur:
    for i in cur:
      for suff in [1, 2, 3, 5, 7, 9]:
        hyp = 10*i + suff

        if is_prime(hyp) and is_trunkable_right(hyp):
          next.append(hyp)
          if is_trunkable_left(hyp):
            yield hyp
    
    cur = next
    next = []


def main():
  print sum(itertools.islice(gen_interesting(), 11))

if __name__ == '__main__':
  main()