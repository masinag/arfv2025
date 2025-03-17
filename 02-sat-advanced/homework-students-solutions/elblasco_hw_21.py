#!/usr/bin/env python3

from pysmt.shortcuts import And, ExactlyOne, Solver, Symbol, BOOL, TRUE

vars = {
    f"x{i}{j}{k}": Symbol(f"x{i}{j}{k}", BOOL)
    for i in range(1, 10)
    for j in range(1, 10)
    for k in range(1, 10)
}

assertions = []

# Each number is conatined exactly once in each row
for number in range(1, 10):
    for row in range(1, 10):
        assertions.append(
            ExactlyOne(
                vars[f"x{row}{col}{number}"]
                for col in range(1, 10)
            )
        )

# Each number is conatined exactly once in each column
for number in range(1, 10):
    for col in range(1, 10):
        assertions.append(
            ExactlyOne(
                vars[f"x{row}{col}{number}"]
                for row in range(1, 10)
            )
        )

# Each number is conatined exactly once in each 3x3 square
for number in range(1, 10):
    for srow in range(1, 10, 3):
        for scol in range(1, 10, 3):
            assertions.append(
                ExactlyOne(
                    vars[f"x{col}{row}{number}"]
                    for row in range(srow, srow + 3)
                    for col in range(scol, scol + 3)
                )
            )

# Each number should appear exactly once in the first diagonal
for number in range(1, 10):
    assertions.append(
        ExactlyOne(
            vars[f"x{row_col}{row_col}{number}"]
            for row_col in range(1, 10)
        )
    )

# Each number should appear once exactly once in the second diagonal
for number in range(1, 10):
    assertions.append(
        ExactlyOne(
            vars[f"x{row_col}{10 - row_col}{number}"]
            for row_col in range(1, 10)
        )
    )

# Hidden: Exactly one number for each cell
for col in range(1, 10):
    for row in range(1, 10):
        assertions.append(
            ExactlyOne(
                vars[f"x{row}{col}{number}"]
                for number in range(1, 10)
            )
        )

# Numbers on the homework slide
assertions.append(
    And(
        vars["x135"], vars["x171"], vars["x244"], vars["x259"], vars["x262"],
        vars["x319"], vars["x393"], vars["x423"], vars["x486"], vars["x529"],
        vars["x581"], vars["x622"], vars["x687"], vars["x711"], vars["x798"],
        vars["x846"], vars["x858"], vars["x867"], vars["x933"], vars["x974"]
    )
)


def print_sudoku_table(model: dict):
    for row in range(1, 10):
        if (row - 1) % 3 == 0:
            print("")
        for col in range(1, 10):
            if (col - 1) % 3 == 0:
                print(" ", end='')
            for num in range(1, 10):
                if model[vars[f"x{row}{col}{num}"]] is TRUE():
                    print(num, end='')
        print('')


with Solver("msat") as solver:
    solver.add_assertions(assertions)
    if solver.solve():
        model = solver.get_model()
        print_sudoku_table(model)
    else:
        print("UNSAT")
