import primes

def primes_from_to(start, stop):
    for p in primes.primes_less_than(stop):
        if p >= start:
            yield p

list(primes.primes_less_than(1000000))
known_primes = set(primes.primes.known_primes)

maxp = 0
maxsl = 0
for a in range(len(primes.primes.known_primes)):
    for b in range(a-1-maxsl):
        s = primes.primes.known_primes[b:a]
        if len(s) > maxsl:
            if sum(s) in known_primes:
                print sum(s), s
                maxsl = len(s)
                maxp = sum(s)
                
