def digitize(n):
    while n > 0:
        yield n % 10
        n /= 10

def undigitize(l):
    r = 0
    m = 1
    for i in l:
        r += i*m
        m *= 10
    return r

def is_palindromic(n):
    l = list(digitize(n))
    return l == list(reversed(l))

def is_lychrel(n):
    for i in xrange(50):
        n += undigitize(reversed(list(digitize(n))))
        if is_palindromic(n):
            return False

    return True

if __name__ == '__main__':
    lychrel = [i for i in range(1, 10000) if is_lychrel(i)]

    print len(lychrel)