import numpy as np

def read_matrix(filename):
    data = np.loadtxt(filename, delimiter=",")
    return data

for t in [0, 1, 2]:
    expected = read_matrix(f"transforma{t}.dat")
    generated = read_matrix(f"my_transforma{t}.dat")

    print(f"\nt = {t}")
    print("max error =", np.max(np.abs(expected - generated)))

    if np.allclose(expected, generated, atol=1e-4):
        print("OK")
    else:
        print("NOT OK")
