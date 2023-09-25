# This python program extends the basic functionality of ASP
# by using the multi-shot solving functionality.
# Multi-shot multiple subprograms to be called and orchestrated 
# by a different program (python). In this case the 
# traveling salesmen person is solved. in which the the cost is 
# optimized using a branch and bound method. 
# 
# Note that the #minimize directive solves this problem easier, 
# but for the sake of understanding, a separate subprogram is
# used to find the optimal (lowest) cost route. 

import sys
from clingo.application import Application, clingo_main
from clingo.control import Control
from clingo.solving import Model
from clingo.symbol import Number

class TravelingSalesPersonApp(Application):
    program_name = "Traveling Salesman Problem"
    version = "1.0"

    def __init__(self):
        self._bound = None

    # for each found model, the bound is set to the new cost 
    def _on_model(self, model: Model):
        self._bound = 0
        atoms = model.symbols(atoms=True)
        
        cost = next(
            atom.arguments[0].number 
            for atom in atoms 
            if atom.match("cost", 1)
        )
        self._bound += cost

    def main(self, ctl: Control, files):
        if not files: files = ["-"]

        for f in files:
            ctl.load(f)

        # add bound subprogram 
        ctl.add("bound", ["b"], ":- cost(X), X >= b.")

        # ground base program
        ctl.ground([("base", [])])

        # solve the grounded program until it is not 
        # satisfiable anymore.
        while ctl.solve(on_model=self._on_model).satisfiable:
            print(f"Found new bound {self._bound}")
            # Ground the 'bound' subprogram with the new bound b.
            # This means that in the next iteration of the search (solve())
            # only models are satisfiable that have a lower cost than the current bound
            # i.e., cost(X) < bound.
            # 
            # Note that this works like a filter for stable models, as each iteration
            # potentially adds (grounds) a tighter lower cost bound. Thus, eventually
            # the minimum will be found.
            ctl.ground([("bound", [Number(self._bound)])])
        
        if self._bound is not None:
            print("Optimum found!")

# clingo_main is the starting point. Provide object that 
# inherits Application and command like arguments 
clingo_main(TravelingSalesPersonApp(), sys.argv[1:])