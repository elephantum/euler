import math
import itertools
from functools import partial
import operator

class PrimesGen:
    class PrimesIter:
        def __init__(self, gen):
            self.gen = gen
            self.i = 0

        def __iter__(self):
            return self

        def next(self):
            ret = self.gen[self.i]
            self.i += 1
            return ret

    def __init__(self):
        self.known_primes = list()

        def generate_primes():
            for n in itertools.count(2):
                sqrt_n = math.sqrt(n)
                for p in itertools.takewhile(partial(operator.ge, sqrt_n), self.known_primes):
                    if n % p == 0:
                        break
                else:
                    self.known_primes.append(n)
                    yield n

        self.generator = generate_primes()

    def __iter__(self):
        return PrimesGen.PrimesIter(self)

    def __getitem__(self, n):
        while len(self.known_primes) <= n:
            self.generator.next()
        return self.known_primes[n]

primes = PrimesGen()

def primes_less_than(n):
    return itertools.takewhile(partial(operator.ge, n), primes)

_factorization_cache = {}
def _factorize(pit, n):
    if n == 1:
        return []

    if n in _factorization_cache:
        return _factorization_cache[n]

    for p in pit:
        if p > n:
            return [n]

        if n % p == 0:
            res = []
            new_n = n
            while new_n % p == 0:
                res.append(p)
                new_n /= p
            res.extend(_factorize(pit, new_n))
            _factorization_cache[n] = res
            return res

def _factorize_wo_cache(n):
    res = []
    for p in primes_less_than(n):
        while n % p == 0:
            res.append(p)
            n /= p
    return res

def factorize(n):
    return _factorize(iter(primes), n)
    #return _factorize_wo_cache(n)


