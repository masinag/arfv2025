from pysmt.shortcuts import And, Equals, Implies, Int, Not, Or, Solver, Symbol
from pysmt.typing import BOOL, INT, FunctionType

agatha = Int(0)
butler = Int(1)
charles = Int(2)
suspects = {agatha: "agatha", butler: "butler", charles: "charles"}

killer = Symbol("killer", INT)

hates = Symbol("hates", FunctionType(BOOL, [INT, INT]))
richer = Symbol("richer", FunctionType(BOOL, [INT, INT]))

assertions = []

# functions properties
for s1 in suspects:
    for s2 in suspects:
        if s1 != s2:
            assertions.append(Implies(richer(s1, s2), Not(richer(s2, s1))))
    assertions.append(Not(richer(s1, s1)))


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
for suspect in suspects:
    assertions.append(Implies(hates(agatha, suspect), Not(hates(charles, suspect))))

# Agatha hates everyone except the butler.
for suspect in suspects:
    if suspect is not butler:
        assertions.append(hates(agatha, suspect))

# The butler hates everyone not richer than Aunt Agatha.
for suspect in suspects:
    assertions.append(Implies(Not(richer(suspect, agatha)), hates(butler, suspect)))

# The butler hates everyone Aunt Agatha hates.
for suspect in suspects:
    assertions.append(Implies(hates(agatha, suspect), hates(butler, suspect)))

# No one hates everyone
for s1 in suspects:
    assertions.append(Or(Not(hates(s1, s2)) for s2 in suspects))

with Solver("msat") as solver:
    solver.add_assertions(assertions)

    while solver.solve():
        model = solver.get_model()
        print(f"Solution: The killer is {suspects[model[killer]]}")
        solver.add_assertion(Not(Equals(killer, model[killer])))
