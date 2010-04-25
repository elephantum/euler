from collections import defaultdict
import primes
import sets

def digitize(n):
    while n > 0:
        yield n % 10
        n /= 10

def get_4d_primes():
    for p in primes.primes_less_than(10000):
        if p > 1000:
            yield p

def group_primes():
    res = defaultdict(list)
    for p in get_4d_primes():
        res[sets.ImmutableSet(digitize(p))].append(p)
    return [v for (k,v) in res.iteritems() if len(v) > 2]

def find_progression(ll):
    if len(ll) >= 3:
        def _check(start, d, ll):
            for i in range(2):
                if start + d*(1+i) not in ll:
                    return False
            return True

        start = ll[0]
        for (idx,next) in enumerate(ll[1:]):
            d = next - start
            if _check(start, d, ll[idx:]):
                yield [start, start + d, start + d + d]

        for i in find_progression(ll[1:]):
            yield i

def find_all_progressions():
    for pp in group_primes():
        for i in find_progression(pp):
            yield i