from pysmt.shortcuts import (
    And,
    Equals,
    Implies,
    Int,
    Ite,
    Not,
    Or,
    Plus,
    Solver,
    Symbol,
)
from pysmt.typing import INT

EMPTY, BALLOON, IRON, BLACK = map(Int, range(4))

areas = [
    [(0, 0), (1, 0), (2, 0), (3, 0), (4, 0), (4, 1)],
    [(1, 1), (2, 1), (3, 1)],
    [(0, 2), (1, 2), (2, 2)],
    [(1, 3), (2, 3), (3, 3)],
    [(0, 3), (0, 4), (1, 4), (2, 4)],
    [(4, 2), (4, 3), (4, 4)],
]

black = [(0, 1), (3, 2), (3, 4)]

vv = [[Symbol(f"x{i}{j}", INT) for j in range(5)] for i in range(5)]


def print_sol(model):
    print("Solution:")
    for i in range(5):
        for j in range(5):
            if model[vv[i][j]] == EMPTY:
                print(" ", end="")
            elif model[vv[i][j]] == BALLOON:
                print("O", end="")
            elif model[vv[i][j]] == IRON:
                print("I", end="")
            elif model[vv[i][j]] == BLACK:
                print("B", end="")
        print()


def main():
    assertions = []

    # each area contains exactly one BALLOON and one IRON BALL
    for area in areas:
        assertions.append(
            Equals(
                Plus(Ite(Equals(vv[i][j], BALLOON), Int(1), Int(0)) for i, j in area),
                Int(1),
            )
        )
        assertions.append(
            Equals(
                Plus(Ite(Equals(vv[i][j], IRON), Int(1), Int(0)) for i, j in area),
                Int(1),
            )
        )
    # balloons must be placed in one of the cells at the top,
    # or in a cell right under a black cell (filled-in cell)
    # or under other balloons
    for i in range(1, 5):
        for j in range(5):
            assertions.append(
                Implies(
                    Equals(vv[i][j], BALLOON),
                    Or(Equals(vv[i - 1][j], BLACK), Equals(vv[i - 1][j], BALLOON)),
                )
            )
    # iron balls must be placed in one of the cells at the bottom,
    # or in a cell right over a black cell
    # or over other iron balls.
    for i in range(4):
        for j in range(5):
            assertions.append(
                Implies(
                    Equals(vv[i][j], IRON),
                    Or(Equals(vv[i + 1][j], BLACK), Equals(vv[i + 1][j], IRON)),
                )
            )
    # Fix black cells
    for i in range(5):
        for j in range(5):
            if (i, j) in black:
                assertions.append(Equals(vv[i][j], BLACK))
            else:
                assertions.append(
                    Or(
                        Equals(vv[i][j], EMPTY),
                        Equals(vv[i][j], IRON),
                        Equals(vv[i][j], BALLOON),
                    )
                )

    with Solver("msat") as solver:
        solver.add_assertions(assertions)
        if solver.solve():
            model = solver.get_model()
            print_sol(model)

            # check if it's unique
            solver.add_assertion(
                Not(
                    And(
                        Equals(vv[i][j], model[vv[i][j]])
                        for i in range(5)
                        for j in range(5)
                    )
                )
            )
            if solver.solve():
                print("The solution is not unique!")
                print_sol(solver.get_model())
            else:
                print("The solution is unique!")
        else:
            print("UNSAT!")


if __name__ == "__main__":
    main()
