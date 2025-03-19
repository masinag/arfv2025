#!/usr/bin/env python3

# https://logic.puzzlebaron.com/play.php?u2=9db6a5914e4ef572fe50bc57bac9efd5

from pysmt.shortcuts import (
    Not, Or, And, ExactlyOne, Solver, Symbol, BOOL, TRUE
)

prices = ["45", "60", "75", "90", "105"]
winners = ["alejandro", "brandon", "linda", "nick", "walter"]
butterflies = ["atlas", "clearwing", "grayling", "peacock", "peppered"]

wvars = {
    f"{price}{winner}": Symbol(f"{price}{winner}", BOOL)
    for price in prices
    for winner in winners
}

bvars = {
    f"{price}{butterfly}": Symbol(f"{price}{butterfly}", BOOL)
    for price in prices
    for butterfly in butterflies
}

assertions = []

# 1. Walter's purchase didn't cost $105.
assertions.append(
    Not(wvars["105walter"])
)

# 2. The five butterflies were Nick's purchase, the butterfly that sold for $45
# the peacock butterfly, the butterfly that sold for $90 and the butterfly that
# sold for $105.

# Nick did not do any purchase of 45$, 90$ or 105$
assertions.append(
    Not(
        Or(
            wvars["45nick"], wvars["90nick"], wvars["105nick"]
        )
    )
)

# The peacock has not been bought for 45$, 90$ or 105$
assertions.append(
    Not(
        Or(
            bvars["45peacock"], bvars["90peacock"], bvars["105peacock"]
        )
    )
)

# Nick did not buy the peacock butterfly for the remaining prices
assertions.append(
    Not(
        Or(
            And(
                wvars[f"{price}nick"], bvars[f"{price}peacock"]
            )
            for price in ["60", "75"]
        )
    )
)

# 3. The grayling butterfly cost 15 dollars less than the atlas butterfly.
assertions.append(
    Or(
        And(bvars["45grayling"], bvars["60atlas"]),
        And(bvars["60grayling"], bvars["75atlas"]),
        And(bvars["75grayling"], bvars["90atlas"]),
        And(bvars["90grayling"], bvars["105atlas"]),
    )
)

# 4. Linda's purchase was either the insect that sold for $60 or the grayling
# butterfly.

# Formula to encode "Linda bought grayling for a price which was not 60$"
linda_bought_grayling = Or(
    And(
        wvars[f"{price}linda"], bvars[f"{price}grayling"]
    )
    for price in prices
    if price != "60"
)

assertions.append(
    Or(
        And(wvars["60linda"], Not(bvars["60grayling"])),
        And(Not(wvars["60linda"]), linda_bought_grayling)
    )
)

# 5. Of the clearwing butterfly and the peacock butterfly, one sold for $105
# and the other was won by Alejandro.

# Alejandro bought a clearwing for not 105$
alejandro_bought_clearwing = Or(
    And(
        wvars[f"{price}alejandro"], bvars[f"{price}clearwing"]
    )
    for price in prices
    if price != "105"
)

# Alejandro bought a peacock for not 105$
alejandro_bought_peacock = Or(
    And(
        wvars[f"{price}alejandro"], bvars[f"{price}peacock"]
    )
    for price in prices
    if price != "105"
)


assertions.append(
    Or(
        # In this case someone bought peacock for 105$ and alejandro one of the
        # other butterflies
        And(
            bvars["105peacock"], alejandro_bought_clearwing
        ),
        # In this case someone bought clearwing for 105$ and alejandro one of
        # the other butterflies
        And(
            bvars["105clearwing"], alejandro_bought_peacock
        )
    )
)

# Each price must be associated with exactly one winner
for price in prices:
    assertions.append(
        ExactlyOne(
            wvars[f"{price}{winner}"] for winner in winners
        )
    )

# Each price must be associated with exactly one butterfly
for price in prices:
    assertions.append(
        ExactlyOne(
            bvars[f"{price}{butterfly}"] for butterfly in butterflies
        )
    )

# Each winner must be associated with exactly one price
for winner in winners:
    assertions.append(
        ExactlyOne(
            wvars[f"{price}{winner}"] for price in prices
        )
    )

# Each butterfly must be associated with exactly one price
for butterfly in butterflies:
    assertions.append(
        ExactlyOne(
            bvars[f"{price}{butterfly}"] for price in prices
        )
    )

with Solver("msat") as solver:
    solver.add_assertions(assertions)
    if solver.solve():
        # print("SAT", solver.get_model())
        model = solver.get_model()
        for price in prices:
            winner_out = [
                winner
                for winner in winners
                if model[wvars[f"{price}{winner}"]] is TRUE()
            ][0]
            butterfly_out = [
                butterfly
                for butterfly in butterflies
                if model[bvars[f"{price}{butterfly}"]] is TRUE()
            ][0]
            print(f"Price {price}: {winner_out} {butterfly_out}")
    else:
        print("UNSAT")
