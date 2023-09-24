% embedded python code

#script(python)

from clingo.symbol import Number

def square(a):
    a = a.number
    yield Number(a*a)

#end.

n(1..3).

f(X, @square(X)) :- n(X).

