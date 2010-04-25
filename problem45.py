import math
import itertools

def is_triangle(n):
    t = math.sqrt(n*2)
    t1 = int(math.ceil(t))
    t2 = int(math.floor(t))

    if t1 == t2: return False

    return t1*t2/2 == n

def is_pentagonal(m):
    '''
    m = n*(3*n - 1)/2
    3*n*n - n - 2*m = 0
    det = sqrt(1 + 24*m)
    n = (1 + det)/6
    '''

    det2 = 1 + 24*m
    det = int(math.sqrt(det2))
    if det*det <> det2: return False

    n = (1 + det)/6
    if n*6 <> 1 + det: return False

    return True

def hexagonal(n):
    return n*(2*n - 1)

def interesting():
    for i in itertools.count(1):
        n = hexagonal(i)

        if is_pentagonal(n) and is_triangle(n):
            yield n