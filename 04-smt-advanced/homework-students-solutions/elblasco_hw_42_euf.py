#!/usr/bin/env python3
from pysmt.shortcuts import (
    And,
    Equals,
    Implies,
    Int,
    Or,
    Solver,
    Symbol,
    ExactlyOne,
    Not
)
from pysmt.typing import BOOL, INT, FunctionType

A = Int(0)
B = Int(1)
C = Int(2)
D = Int(3)
E = Int(4)
last = Symbol("last", INT)
scheduled_before = Symbol("scheduled-before", FunctionType(BOOL, [INT, INT]))

processes_names: list = [A, B, C, D, E]
tasks: list = ["A", "B", "C", "D", "E"]

assertions: list = []

# Reflexive: if x is a task then "x is scheduled before x" can be
for x in processes_names:
    assertions.append(
        scheduled_before(x, x)
    )

# Antisymmetry: if "x is scheduled before y" and "y is scheduled before x"
# then x = y
for x in processes_names:
    for y in processes_names:
        assertions.append(
            Implies(
                And(
                    scheduled_before(x, y),
                    scheduled_before(y, x)
                ),
                (Equals(x, y))
            )
        )

# Transitivity: if "x is scheduled before y" and "y is scheduled before z",
# then "x is scheduled before z"
for x in processes_names:
    for y in processes_names:
        for z in processes_names:
            assertions.append(
                Implies(
                    And(
                        scheduled_before(x, y),
                        scheduled_before(y, z)
                    ),
                    scheduled_before(x, z)
                )
            )

# We can execute A after D is completed
assertions.append(scheduled_before(D, A))

# We can execute B after C and E are completed
assertions.append(
    And(
        scheduled_before(C, B),
        scheduled_before(E, B)
    )
)

# We can execute E after B or D are completed
assertions.append(
    Or(
        scheduled_before(B, E),
        scheduled_before(D, E)
    )
)

# We can execute C after A is completed
assertions.append(scheduled_before(A, C))

# "last" should be one of the tasks
assertions.append(
    ExactlyOne(
        Equals(last, x)
        for x in processes_names
    )
)

# If a task is not "last" then it is executed before "last":
for x in processes_names:
    assertions.append(
        Implies(
            Not(Equals(x, last)),
            scheduled_before(x, last)
        )
    )

with Solver("msat") as msat:
    msat.add_assertions(assertions)
    if msat.solve():
        print("Solution found!")
        model = msat.get_model()
        extracted_last = model[last].constant_value()
        print("Last has value",
              extracted_last,
              "so the last task to get executed is",
              tasks[extracted_last])
    else:
        print("No solution exists!")
