from pysmt.shortcuts import (
    And,
    Equals,
    Exists,
    ForAll,
    Implies,
    Int,
    Not,
    Or,
    Solver,
    Symbol,
)
from pysmt.typing import BOOL, INT, FunctionType


agatha = Int(0)
butler = Int(1)
charles = Int(2)
suspects = {agatha: "agatha", butler: "butler", charles: "charles"}

killer = Symbol("killer", INT)
x = Symbol("x", INT)
y = Symbol("y", INT)

hates = Symbol("hates", FunctionType(BOOL, [INT, INT]))
richer = Symbol("richer", FunctionType(BOOL, [INT, INT]))

assertions = []

# functions properties
assertions.append(ForAll([x], Not(richer(x, x))))
assertions.append(ForAll([x, y], Implies(richer(x, y), Not(richer(y, x)))))


# Someone who lives in Dreadbury Mansion killed Aunt Agatha.
# Agatha, the butler, and Charles are the only ones living in Dreadbury Mansion
assertions.append(
    Or(
        Equals(killer, agatha),
        Equals(killer, butler),
        Equals(killer, charles),
    )
)

# A killer always hates his victim, and is never richer than his victim.
assertions.append(And(hates(killer, agatha), Not(richer(killer, agatha))))

# Charles hates no one that Aunt Agatha hates.
assertions.append(ForAll([x], Implies(hates(agatha, x), Not(hates(charles, x)))))

# Agatha hates everyone except the butler.
assertions.append(ForAll([x], Implies(Not(Equals(x, butler)), hates(agatha, x))))

# The butler hates everyone not richer than Aunt Agatha.
assertions.append(ForAll([x], Implies(Not(richer(x, agatha)), hates(butler, x))))

# The butler hates everyone Aunt Agatha hates.
assertions.append(ForAll([x], Implies(hates(agatha, x), hates(butler, x))))

# No one hates everyone
assertions.append(ForAll([x], Exists([y], Not(hates(x, y)))))

with Solver("z3") as solver:
    solver.add_assertions(assertions)

    while solver.solve():
        model = solver.get_model()
        print(f"Solution: The killer is {suspects[model[killer]]}")
        solver.add_assertion(Not(Equals(killer, model[killer])))
