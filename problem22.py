names_raw = [i.strip().strip('"').upper() for i in file('problem22-data.txt').read().split(',')]
names = sorted(names_raw)

print names[:100]

def num_val(name):
    return sum(ord(i) - ord('A') + 1 for i in name)

print sum((n+1)*num_val(name) for (n, name) in enumerate(names))
