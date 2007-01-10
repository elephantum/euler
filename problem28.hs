diag = 1 : diag' 1 1
    where diag' last r = a : b : c : d : diag' d (r+1)
              where a = last + r * 2
                    b = a + r * 2
                    c = b + r * 2
                    d = c + r * 2

ans = sum $ take (1 + 1000*2) diag