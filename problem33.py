from problem32 import list_to_num, num_to_list
import itertools
import operator

class PrimesGen:
  class PrimesIter:
    def __init__(self, gen):
      self.gen = gen
      self.i = 0

    def next(self):
      ret = self.gen[self.i]
      self.i += 1
      return ret

  def __init__(self):
    self.known_primes = list()
    self.n = 2

  def __iter__(self):
    return PrimesGen.PrimesIter(self)

  def next(self):
    for p in self.known_primes:
      if self.n%p == 0:
        break
    else:
      self.known_primes.append(self.n)

    ret = self.n
    self.n += 1
    return ret

  def __getitem__(self, n):
    while len(self.known_primes) <= n:
      self.next()
    return self.known_primes[n]

primes = PrimesGen()

def factorize(n):
  for p in primes:
    if n < p:
      break

    while n%p == 0:
      yield p
      n /= p

class PeekingIter:
  def __init__(self, it):
    self.it = iter(it)
    self.hasval = None
    self.nextval = None
    self._peek()

  def _peek(self):
    try:
      self.nextval = self.it.next()
      self.hasval = True
    except StopIteration:
      self.hasval = False

  def next(self):
    if self.hasval:
      ret = self.nextval
      self._peek()
      return ret
    else:
      raise StopIteration()

def gcd(a, b):
  a_fact = PeekingIter(factorize(a))
  b_fact = PeekingIter(factorize(b))

  common = []
  while a_fact.hasval and b_fact.hasval:
    c = cmp(a_fact.nextval, b_fact.nextval)

    if c == 0:
      common.append(a_fact.nextval)
      a_fact.next()
      b_fact.next()
    elif c < 0:
      a_fact.next()
    else:
      b_fact.next()

  return reduce(operator.mul, common, 1)

def dummy_simplify(a, b):
  ''' simplify fraction a/b '''

  a_list = list(num_to_list(a))
  b_list = list(num_to_list(b))

  common_digits = set(a_list).intersection(set(b_list))

  def flt(l): return list_to_num(d for d in l if d not in common_digits)

  return flt(a_list), flt(b_list)

def correctly_simplify(a, b):
  t = gcd(a, b)

  return a/t, b/t

def fractions_equal((a_num, a_den), (b_num, b_den)):
  a_norm = correctly_simplify(a_num, a_den)
  b_norm = correctly_simplify(b_num, b_den)

  return a_norm == b_norm

def interesting_fractions():
  for a in range(1, 100):
    for b in range(a+1, 100):
      dummy = dummy_simplify(a, b)
      corr = correctly_simplify(a, b)

      if (dummy[0]*10, dummy[1]*10) <> (a,b) and dummy <> (a, b) and fractions_equal(dummy, corr):
        yield a, b

def main():
  frs = list(interesting_fractions())
  cum_a = reduce(operator.mul, [a for a, b in frs])
  cum_b = reduce(operator.mul, [b for a, b in frs])

  print correctly_simplify(cum_a, cum_b)

if __name__ == '__main__':
  main()
