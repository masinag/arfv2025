from pysmt.shortcuts import *
N_ROWS = 5
N_COLS = 5

xx = {f"x_{i}_{j}": Symbol(f"x_{i}{j}", BOOL) for i in range(N_ROWS) for j in range(N_COLS)}

def encode_row(row, n_consecutive):
    cases = []
    for i in range(N_COLS - n_consecutive + 1):
        case = []
        for j in range(i):
            case.append(Not(xx[f"x_{row}_{j}"]))
        for j in range(i, i + n_consecutive):
            case.append(xx[f"x_{row}_{j}"])
        for j in range(i + n_consecutive, N_COLS):
            case.append(Not(xx[f"x_{row}_{j}"]))
        cases.append(And(case))
    return Or(cases)


def encode_col(col, n_consecutive):
    cases = []
    for i in range(N_ROWS - n_consecutive + 1):
        case = []
        for j in range(i):
            case.append(Not(xx[f"x_{j}_{col}"]))
        for j in range(i, i + n_consecutive):
            case.append(xx[f"x_{j}_{col}"])
        for j in range(i + n_consecutive, N_ROWS):
            case.append(Not(xx[f"x_{j}_{col}"]))
        cases.append(And(case))
    return Or(cases)


def print_solution(model):
    for i in range(N_ROWS):
        for j in range(N_COLS):
            if model[xx[f"x_{i}_{j}"]]==TRUE():
                print("X", end="")
            else:
                print(" ", end="")
        print()

assertions = []

assertions.append(encode_row(0, 2))
assertions.append(encode_row(1, 3))
assertions.append(encode_row(2, 3))
assertions.append(And(xx[f"x_{3}_{0}"], xx[f"x_{3}_{1}"], xx[f"x_{3}_{2}"], Not(xx[f"x_{3}_{3}"]), xx[f"x_{3}_{4}"]))
assertions.append(encode_row(4, 1))

assertions.append(encode_col(0, 2))
assertions.append(encode_col(1, 3))
assertions.append(encode_col(2, 4))
assertions.append(encode_col(3, 2))
assertions.append(encode_col(4, 2))

with Solver("msat") as msat:
    msat.add_assertions(assertions)

    if msat.solve():
        print("Solution found!")
        print_solution(msat.get_model())
    else:
        print("No solution exists!")
