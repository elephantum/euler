import operator
import problem32

def factorial(n):
  if n <= 1:
    return 1
  else:
    return reduce(operator.mul, range(1, n+1))

def is_interesting(n):
  return n == sum(map(factorial, problem32.num_to_list(n)))

max_n_to_check = 2540160

for n in range(10, max_n_to_check):
  if is_interesting(n):
    print n