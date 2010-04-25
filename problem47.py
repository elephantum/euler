import primes
import itertools

def count_factors(n):
    return len(set(primes.factorize(n)))

def is_interesting(n):
    for i in range(4):
        if count_factors(n+i) < 4:
            return False
    
    return True

def find_n():
    for i in itertools.count():
        if count_factors(i) >= 3:
            for d in range(4):
                if is_interesting(i*4 - d):
                    return i*4 - d
