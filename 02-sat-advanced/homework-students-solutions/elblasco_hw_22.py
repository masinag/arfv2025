#!/usr/bin/env python3

# https://logic.puzzlebaron.com/play.php?u2=9db6a5914e4ef572fe50bc57bac9efd5

from pysmt.shortcuts import Or, And, ExactlyOne, Solver, Symbol, BOOL, TRUE

months = ["jan", "feb", "mar", "apr"]
names = ["guadalupe", "keith", "ollie", "yvette"]
cultures = ["ashdage", "fujishiro", "stosam", "yersim"]

nvars = {
    f"{month}{name}": Symbol(f"{month}{name}", BOOL)
    for month in months
    for name in names
}

cvars = {
    f"{month}{culture}": Symbol(f"{month}{culture}", BOOL)
    for month in months
    for culture in cultures
}

assertions = []

# 1.Ollie has been studying the Stosam culture.
assertions.append(
    Or(
        And(nvars[f"{month}ollie"], cvars[f"{month}stosam"])
        for month in months
    )
)

# 2. Keith will publish 1 month after the person who has been studying the
# Stosam culture.

assertions.append(
    Or(
        And(nvars["febkeith"], cvars["janstosam"]),
        And(nvars["markeith"], cvars["febstosam"]),
        And(nvars["aprkeith"], cvars["marstosam"])
    )
)

# 3. The student who will publish in March is either the person who has been
# studying the Yersim culture or Guadalupe.

assertions.append(
    ExactlyOne(
        cvars["maryersim"], nvars["marguadalupe"]
    )
)

# 4. The student who has been studying the Fujishiro culture will publish 1
# month after Yvette.

assertions.append(
    ExactlyOne(
        And(nvars["janyvette"], cvars["febfujishiro"]),
        And(nvars["febyvette"], cvars["marfujishiro"]),
        And(nvars["maryvette"], cvars["aprfujishiro"])
    )
)

# Each month must be associated with exactly one name
for month in months:
    assertions.append(
        ExactlyOne(
            nvars[f"{month}{name}"] for name in names
        )
    )

# Each month must be associated with exactly one culture
for month in months:
    assertions.append(
        ExactlyOne(
            cvars[f"{month}{culture}"] for culture in cultures
        )
    )

# Each name must be associated with exactly one month
for name in names:
    assertions.append(
        ExactlyOne(
            nvars[f"{month}{name}"] for month in months
        )
    )

# Each culture must be associated with exactly one month
for culture in cultures:
    assertions.append(
        ExactlyOne(
            cvars[f"{month}{culture}"] for month in months
        )
    )

with Solver("msat") as solver:
    solver.add_assertions(assertions)
    if solver.solve():
        # print("SAT", solver.get_model())
        model = solver.get_model()
        for month in months:
            name_out = [
                name
                for name in names
                if model[nvars[f"{month}{name}"]] is TRUE()
            ][0]
            culture_out = [
                culture
                for culture in cultures
                if model[cvars[f"{month}{culture}"]] is TRUE()
            ][0]
            print(f"Month {month}: {name_out} {culture_out}")
    else:
        print("UNSAT")
