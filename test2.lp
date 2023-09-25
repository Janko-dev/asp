
#program base.

state(a; b; c).

#program step(k).

#external col(X, k): state(X).


#script(python)

from clingo.symbol import Number, Function, String

def main(prg):
    prg.ground([("base", [])])
    prg.ground([("step", [Number(42)])])

    prg.assign_external(Function("col", [Function("a"), Number(42)]), True)
    
    prg.solve()

#end.
