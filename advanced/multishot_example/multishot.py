

from clingo.symbol import Number, Function
from clingo.control import Control

# initialise control object for the grounding/solving process 
ctl = Control()

# load simple.lp program
ctl.load("simple.lp")

# ground both subprograms, where subprogram 'acid' is initialised
# with program argument 42 
ctl.ground([
    ("acid", [Number(42)]),
    ("base", []),
])

# assignment of truth value for external (grounded) rule.
# Note: assignment_external MUST come after grounding. 
ctl.assign_external(Function('d', [Number(2), Number(42)]), True)

# solve grounded program and print to stdout
ctl.solve(on_model=print)

