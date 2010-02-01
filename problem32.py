# -*- coding: utf-8 -*-

def num_to_list(n):
  while n:
    yield n % 10
    n /= 10

def list_to_num(l):
  return sum(d * (10 ** n) for n, d in enumerate(l))

def gen_num(num_len, digits):
  '''
   num_len -- длина числа
   digits -- доступные разряды

   @return число, оставшиеся разряды
  '''

  def _gen_num(num_len, digits):
    ''' @return число-как-список, оставшиеся разряды '''

    if num_len > 0:
      for digit in digits:
        left_digits = digits - set([digit])

        for suffix, suffix_left_digits in _gen_num(num_len - 1, left_digits):
          yield [digit] + suffix, suffix_left_digits 
    else:
      yield ([], digits)

  for num, left_digits in _gen_num(num_len, digits):
    if len(num) > 0:
      yield list_to_num(num), left_digits 

def gen_muls():
  '''
  генератор, возвращает пары (a, b) множителей
  '''

  digits = set(range(1, 10))

  for a_len, b_len in [(1, 4), (2, 3)]:
    for a, a_left_digits in gen_num(a_len, digits):
      for b, _ in gen_num(b_len, a_left_digits):
        yield a, b

def interesting_muls(a, b):
  a_digits = list(num_to_list(a))
  b_digits = list(num_to_list(b))
  ab_digits = list(num_to_list(a*b))

  id_digits = a_digits + b_digits + ab_digits

  return (
    len(id_digits) == 9 and
    set(range(1, 10)) == set(id_digits))

def interesting_ids():
  for a, b in gen_muls():
    if interesting_muls(a, b):
      yield a, b, a*b

if __name__ == "__main__":
  interesting_abs = set(ab for a, b, ab in interesting_ids())
  print sum(interesting_abs)
