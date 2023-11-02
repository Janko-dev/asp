from clingo.control import Control
from clingo.symbol import Number

ENCODING = "meta_encoding.lp"

solutions = []
n = 0
while len(solutions) == 0:
    constraints = ""
    
    ctl = Control(["0"])
    ctl.load(ENCODING)
    ctl.ground([("meta", [Number(n)]), ("generate", []), ("violations", [])])
    for model in ctl.solve(yield_=True):
        atoms = [f"{atom.__str__()}" for atom in model.symbols(shown=True)]
        constraints += f":- {', '.join(atoms)}.\n"
    
    print(f"Iteration {n}:")
    print(constraints)

    ctl = Control(["0"])
    ctl.load(ENCODING)
    ctl.add("constraints", [], constraints)
    ctl.ground([("meta", [Number(n)]), ("generate", []), ("constraints", [])])
    for model in ctl.solve(yield_=True):
        solutions.append(model)
    n += 1

print("Solutions:")
for model in solutions:
    print(model)