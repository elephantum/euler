import math

def char_to_n(c):
    n = ord(c) - ord('A') + 1
    return n

def word_to_n(w):
    return sum(map(char_to_n, w))

def is_tn(n):
    t = math.sqrt(n*2)
    t1 = int(math.ceil(t))
    t2 = int(math.floor(t))

    if t1 == t2: return False

    return t1*t2/2 == n

def read_words():
    data_raw = file('problem42_data.txt').read()
    return [i.strip('"') for i in data_raw.split(',')]

if __name__ == '__main__':
    words = read_words()

    triangular_words = [i for i in words if is_tn(word_to_n(i))]

    print triangular_words, len(triangular_words)