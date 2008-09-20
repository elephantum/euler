_ip.magic("ed ")
input_data
_ip.magic("ed ")
input_data
len(input_data
)
def get(x,y):
    if x >= 20 or y >= 20 or x < 0 or y < 0: return 0
    else: return input_data[x][y]
    

get(0,0)
get(0,19)
def moved(dx, dy):
    return [[get(x+dx,y+dy) for y in range(20)] for x in range(20)]

moved(1,0)
input_data
input_data
moved(1,0)
input_data
_ip.magic("ed moved")
def moved(dx, dy):
    return [[get(x+dx,y+dy) for x in range(20)] for y in range(20)]

moved(1,0)
input_data
moved(1,0)
def moved(dx, dy):
    return [[get(x+dx,y+dy) for y in range(20)] for x in range(20)]

moved(1,0)
input_data
def mul(a, b):
    return [[a[x][y] * b[x][y] for y in range(20)] for x in range(20)]

mul(input_data, moved(1,0))
def diag(dx, dy):
    return [moved(dx*i, dy*i) for i in range(4)]

diag(1,0)
reduce(mul, diag(1,0))
def mmax(a):
    return max(a[x][y] for x in range(20) for y in range(20))

mmax(input_data)
def mdiag(dx, dy): return reduce(mul, diag(dx, dy))

mmax(mdiag(1,0)
)
mmax(mdiag(1,0))
mmax(mdiag(1,1))
mmax(mdiag(0,1))
mmax(mdiag(1,-1))
_ip.magic("%hist -n")
