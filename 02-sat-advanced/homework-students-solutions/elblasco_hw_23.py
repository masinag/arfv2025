#!/usr/bin/env python

from pysmt.shortcuts import (
    Not, Or, ExactlyOne, Solver, Symbol, BOOL, Implies, TRUE
)


# Build the dictionary with all the variables
def build_board(n: int) -> dict:
    return {
        f"cb{i}{j}": Symbol(f"cb{i}{j}", BOOL)
        for i in range(n)
        for j in range(n)
    }


# There can be exactly one queen per row
def one_queen_per_row(board: dict, assertiosn: list, n: int):
    for row in range(n):
        assertions.append(
            ExactlyOne(
                board[f"cb{row}{col}"]
                for col in range(n)
            )
        )


# There can be exactly one queen per column
def one_queen_per_col(board: dict, assertiosn: list, n: int):
    for col in range(n):
        assertions.append(
            ExactlyOne(
                board[f"cb{row}{col}"]
                for row in range(n)
            )
        )


# If there is a queen in the cell <row, col> then cannot be any other queen in
# <row, col> diagonal and anti-diagonal
def one_queen_per_diagonal(board: dict, assertions: list, n: int):
    for row in range(n):
        for col in range(n):
            diagonal_conflicts = []
            anti_diagonal_conflicts = []

            for row_diag in range(n):
                # Check the diagonal (row - col is constant)
                col_diag = row_diag + (col - row)
                if 0 <= col_diag < n and (row_diag != row or col_diag != col):
                    diagonal_conflicts.append(board[f"cb{row_diag}{col_diag}"])
                # Check the anti-diagonal (row + col is constant)
                col_anti_diag = (row + col) - row_diag
                if 0 <= col_anti_diag < n and (row_diag != row or col_diag != col):
                    anti_diagonal_conflicts.append(
                        board[f"cb{row_diag}{col_diag}"]
                    )

            assertions.append(
                Implies(
                    board[f"cb{row}{col}"],
                    Not(Or(diagonal_conflicts + anti_diagonal_conflicts))
                )
            )


# Just printa model formatted as a chess-board, the queens are positioned on
# the black squares
def print_chess_board(model: dict, board: dict, n: int):
    for row in range(n):
        for col in range(n):
            if model[board[f"cb{row}{col}"]] is TRUE():
                print("■", end='')
            else:
                print("□", end='')
        print('')


if __name__ == "__main__":
    n: int = int(input("Insert the chess-board size: "))
    board: dict = build_board(n)
    assertions: list = []
    one_queen_per_row(board, assertions, n)
    one_queen_per_col(board, assertions, n)
    one_queen_per_diagonal(board, assertions, n)
    solver = Solver("msat")
    solver.add_assertions(assertions)
    if solver.solve():
        model = solver.get_model()
        print("SAT")
        print_chess_board(model, board, n)
        # If the formula is SAT then we falsify at least one TRUE assignment
        current_display: list = [
            Or(
                Not(board[f"cb{row}{col}"])
                for row in range(n)
                for col in range(n)
                if model[board[f"cb{row}{col}"]] is TRUE()
            )
        ]
        solver.add_assertions(current_display)
        if solver.solve():
            print("The model is non-unique")
            print_chess_board(solver.get_model(), board, n)
        else:
            print("The model is unique")
