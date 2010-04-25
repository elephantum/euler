import math
import itertools

def pentagonal(n):
    return n*(3*n - 1)/2

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

'''
d(3d - 1)/2 = a/(3a - 1)/2 - b/(3b - 1)/2
3dd - d - 3aa + a + 3bb - b = 0
det = sqrt(1 + 4(3aa - a - 3bb + b))
'''

'''
(n+1)(3(n+1) - 1)/2 - n(3n - 1)/2 < d
(n+1)(3n + 2) - 3nn + n < 2d
3nn + 2n + 3n + 2 -3nn + n < 2d
6n + 2 < 2d
3n < d - 1
'''

def find_d():
    for a in itertools.count(1):
        pa = pentagonal(a)
        for b in range(1, a):
            pb = pentagonal(b)
            if is_pentagonal(pa - pb) and is_pentagonal(pa + pb):
                return pa - pb

#def find_d():
#    for d in itertools.count(1):
#        pd = pentagonal(d)
#        for a in range(1, int((d-1)/3)+1):
#            pa = pentagonal(a)
#            pb = pa + pd
#            if is_pentagonal(pb) and is_pentagonal(pa+pb):
#                return pd