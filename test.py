import sys
from clingo.application import Application, clingo_main
from clingo.control import Control
from clingo.solving import Model
from clingo.symbol import Number

class TestApp(Application):
    program_name = "test"
    version = "1.0"

    def __init__(self):
        self._bound = None

    def _on_model(self, model: Model):
        
        pass

    def main(self, ctl: Control, files):
        if not files: files = ["-"]

        for f in files:
            ctl.load(f)

        ctl.add("bound", ["b"], "p(b).")

        # ground base program
        ctl.ground([("base", [])])

        ctl.ground([("bound", [Number(1)])])
        ctl.ground([("bound", [Number(2)])])
        ctl.ground([("bound", [Number(3)])])

        ctl.solve(on_model=self._on_model)

clingo_main(TestApp(), sys.argv[1:])