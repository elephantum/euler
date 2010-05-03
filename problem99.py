import math

def read_data():
    with file('problem99_data.txt') as f:
        for (line_no,line) in enumerate(f):
            n_raw, m_raw = line.split(',')
            n = int(n_raw)
            m = int(m_raw)
            yield (math.log10(n)*m, line_no)

print max(read_data(), key=lambda x: x[0])
