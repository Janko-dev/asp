
student(dave; mary; pat; bob).
dept(math; cs; english).

in(dave, english).
in(mary, cs).
in(bob, cs).
in(pat, math).

-in(S, D1) :- dept(D1),
              in(S, D2),
              D1 != D2.

afraid(S, math) :- student(S),
                   not ab(d(S)),
                   not -afraid(S, math).

% strong exception (mary is not afraid of math)
-afraid(mary, math).
ab(d(mary)).

% strong exception (math students are not afraid of math)
-afraid(S, math) :- student(S), in(S, math).
ab(d(S)) :- student(S), not -in(S, math).

% weak exception (CS students may or may not be afraid of math)
ab(d(S)) :- student(S), not -in(S, cs).


% new student Jake with unknown department
person(jake).
% there is not enough evidence to entail Jake's feeling about math.  

#show afraid/2.
#show -afraid/2.