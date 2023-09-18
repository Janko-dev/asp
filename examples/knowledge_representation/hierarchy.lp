
% define classes
class(vehicle).
class(water).
class(land).
class(air).
class(ship).
class(submarine).
class(truck).
class(car).
class(airplane).

% define subclasses
is_subclass(water, vehicle).
is_subclass(land, vehicle).
is_subclass(air, vehicle).

is_subclass(ship, water).
is_subclass(submarine, water).

is_subclass(truck, land).
is_subclass(car, land).

is_subclass(airplane, air).

% recursive definition of subclass
subclass(X, C) :- is_subclass(X, C).
subclass(X, C) :- is_subclass(X, C1), subclass(C1, C).

-subclass(X, C) :- class(X), 
                   class(C), 
                   not subclass(X, C).

% define objects
object(narwhal).
object(abby).

is_a(narwhal, submarine).
is_a(abby, car).

% define membership
member(X, C) :- is_a(X, C).
member(X, C) :- is_a(X, C1), subclass(C1, C).
-member(X, Y) :- object(X), class(Y), not member(X, Y).
#show -member/2.