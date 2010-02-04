import itertools

def is_palindrome(l):
    for (i, c) in enumerate(l[:len(l)/2]):
        if c <> l[-i-1]:
            return False
    else:
        return True

def num_to_list(n, base):
    def _do(n):
        while n > 0:
            yield n % base
            n /= base

    return list(_do(n))

def list_to_num(l, base):
    return sum(i * base**n for (n, i) in enumerate(l))

def interesting_numbers():
    for i in range(1000000):
        if is_palindrome(num_to_list(i, 10)) and is_palindrome(num_to_list(i, 2)):
            print i, num_to_list(i, 10), num_to_list(i, 2)
            yield i

print sum(interesting_numbers())