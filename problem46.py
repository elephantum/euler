import math
import primes
import itertools

def is_int_square(n):
    s = int(math.sqrt(n))
    return s*s == n

def is_goldbach_true(n):
    for p in itertools.takewhile(lambda x: x<n, primes.primes):
        if is_int_square((n - p)/2):
            return True
    
    if n in primes.primes.known_primes:
        return True

    return False

def find_interesting():
    for i in itertools.count(1):
        n = i*2+1
        if not is_goldbach_true(n):
            return n