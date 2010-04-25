def permutations(ll, pp):
    def _p(acc, ll, pp):
        if len(ll) == 0:
            yield acc
        else:
            p = pp[0]
            for (n,c) in enumerate(ll):
                acc_c = acc + [c]
                if p is None or p(acc_c):
                    for i in _p(acc_c, ll[:n] + ll[n+1:], pp[1:]):
                        yield i
    
    return _p([], ll, pp)

def lton(dd):
    r = 0
    for i in dd:
        r *= 10
        r += i
    return r

def pdiv(n):
    def p(dd):
        return lton(dd[-3:]) % n == 0
    return p

def preds():
    return [lambda x:x[0] <> 0,
            None,
            None] + [pdiv(i) for i in [2,3,5,7,11,13,17]]

def interesting_pandigitals():
    return [lton(i) for i in permutations(range(10), preds())]

print sum(interesting_pandigitals())