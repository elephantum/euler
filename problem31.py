vals = [2, 5, 10, 20, 50, 100, 200]

def generate_divs(n):
    def gen(n, left_vals):
        if len(left_vals) == 0:
            return 1

        res = 0
        for i in range(n/left_vals[0] + 1):
            res += gen(n - left_vals[0]*i, left_vals[1:])

        return res

    return gen(n, vals)

print generate_divs(200)
