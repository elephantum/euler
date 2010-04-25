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
    seq_4 = 0
    for i in itertools.count():
        if count_factors(i) >= 4:
            seq_4 += 1

            if seq_4 == 4:
                return i - 3
        else:
            seq_4 = 0