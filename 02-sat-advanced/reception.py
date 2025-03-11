from pysmt.shortcuts import And, Or, Symbol, BOOL, ExactlyOne, Solver, TRUE

guests = list("ABCDE")
rooms = list("12345")

xx = {f"x_{g}_{r}": Symbol(f"x_{g}_{r}", BOOL) for g in guests for r in rooms}


def print_model(model, i):
    assignment = {}
    for g in guests[: i + 1]:
        room = [r for r in rooms if model[xx[f"x_{g}_{r}"]] == TRUE()]
        assert len(room) == 1
        room = room[0]
        assignment[g] = room
    print(", ".join(f"{g} -> {r}" for g, r in assignment.items()))


def print_core(core):
    print(And(core).serialize())


assertions = []
guests_preferences = []

# Every guest goes in exactly one room
for g in guests:
    assertions.append(ExactlyOne(xx[f"x_{g}_{r}"] for r in rooms))

# Every room hosts exactly one guest
for r in rooms:
    assertions.append(ExactlyOne(xx[f"x_{g}_{r}"] for g in guests))

# Guest A would like to choose room 1 or 2.
guests_preferences.append(Or(xx["x_A_1"], xx["x_A_2"]))

# Guest B would like to choose a room with an even number.
guests_preferences.append(Or(xx["x_B_2"], xx["x_B_4"]))

# Guest C would like the first room.
guests_preferences.append(xx["x_C_1"])

# Guest D has the same behavior as user B.
guests_preferences.append(Or(xx["x_D_2"], xx["x_D_4"]))

# Guest E would like one of the external rooms.
guests_preferences.append(Or(xx["x_E_1"], xx["x_E_5"]))


with Solver("msat", unsat_cores_mode="named") as msat:
    msat.add_assertions(assertions)
    for i, guest_pref in enumerate(guests_preferences):
        msat.push()
        msat.add_assertion(guest_pref)
        if msat.solve():
            print(
                f"Guest number {i+1} can be satisfied",
                end=" ",
            )
            print_model(msat.get_model(), i)
        else:
            print(
                f"Guest number {i+1} cannot be satisfied, because of",
                end=" ",
            )
            print_core(msat.get_unsat_core())
            break
