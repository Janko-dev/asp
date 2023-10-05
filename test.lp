#program step(i).
{ q(i) }.

a(i) :- q(i-1).
a(i) :- a(i-1).

:- a(i), q(i).


#script(python)

from clingo.symbol import Number, Function

def main(prg):

    prg.ground([("step", [Number(0)])])
    prg.ground([("step", [Number(1)])])
    prg.ground([("step", [Number(2)])])

    prg.solve()

#end.