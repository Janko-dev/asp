import sys
from typing import Sequence
from clingo.application import Application, clingo_main
from clingo.control import Control
from clingo.symbol import Number, Function, String
from clingo.solving import Model

import random

class WFC(Application):
    program_name = "WaveFunctionCollapse"
    version = "1.0"

    def __init__(self):
        self.n = 3
        self.clear_entropy()
    
    def clear_entropy(self):
        self.entropy = {}
        for r in range(1, self.n+1):
            for c in range(1, self.n+1):
                self.entropy[(r, c)] = set()

    def calc_entropy(self, model: Model):
        
        for atom in model.symbols(shown=True):
            r = atom.arguments[0].number
            c = atom.arguments[1].number
            
            # print(r, c, atom.arguments[2].name)
            self.entropy[(r, c)].add(atom.arguments[2].name)
        
        # print(self.entropy)

    def main(self, ctl: Control, files: Sequence[str]):
        
        # print(ctl._rep)
        ctl = Control("0")

        for file in files:
            ctl.load(file)
        
        ctl.ground([("base", [Number(self.n)]), ("check", [])])

        for _ in range(3):

            with ctl.solve(yield_=True) as handle:
                for model in handle:
                    # print("TEST", model)
                    self.calc_entropy(model)

            # pick random position and collapse it
            sort = sorted(self.entropy.values(), key=lambda x: len(x))
            m = len(sort[0])
            i = 0
            while m == 1 and i < len(sort):
                m = len(sort[i])
                i += 1
            
            # m = len(min(self.entropy.values(), key=len))
            collapse_choices = [(k, v) for k, v in self.entropy.items() if len(v) != 1 and len(v) == m]
            (r, c), state = random.choice(collapse_choices)
            print(r, c, state)
            print(self.entropy)
            ctl.assign_external(
                Function("collapsed", [
                    Number(r), Number(c),
                    String(random.choice(tuple(state)))
                ]), True)
            self.clear_entropy()

            ctl.ground([("step", []), ("check", [])])


clingo_main(WFC(), sys.argv[1:])