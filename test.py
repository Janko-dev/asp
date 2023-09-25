import sys
from clingo.application import Application, clingo_main
from clingo.control import Control
from clingo.solving import Model
from clingo.symbol import Number, Function, String

class TestApp(Application):
    program_name = "test"
    version = "1.0"

    def _on_model(self, model: Model):
        print(model)

    def main(self, ctl: Control, files):

        for f in files:
            ctl.load(f)

        

        # ground base program
        ctl.ground([("base", []), ("step", [])])

        ctl.assign_external(Function("col", [String("a")]), True)

        ctl.solve(on_model=self._on_model)

clingo_main(TestApp(), sys.argv[1:])