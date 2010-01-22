def digitize(n):
    while n > 0:
        yield n % 10
        n = n / 10

def interesting(n):
    return n == sum(i**5 for i in digitize(n))

def all_interesting():
    for n in range(2, 9**5 * 6):
        if interesting(n):
            yield n

print sum(all_interesting())
