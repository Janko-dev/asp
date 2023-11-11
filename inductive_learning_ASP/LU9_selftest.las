% background B
animal(1).
animal(2).

% search space SM
#modeh(animal(var(v))).
#modeh(mamal(var(v))).
#modeh(bird(var(v))).
#modeh(carnivore(var(v))).
#modeh(herbivore(var(v))).

#modeb(animal(var(v))).
#modeb(mamal(var(v))).
#modeb(bird(var(v))).
#modeb(carnivore(var(v))).
#modeb(herbivore(var(v))).

% positive examples
#pos({mamal(1), bird(2), carnivore(1)}, {bird(1), mamal(2)}).
#pos({bird(1), mamal(2), herbivore(2)}, {bird(2), mamal(1)}).
#pos({mamal(1), mamal(2), herbivore(1)}, {bird(1), bird(2)}).

%%%%%%%%% output:
% mamal(V1) :- herbivore(V1).
% carnivore(V1) :- animal(V1).
% bird(V1) :- animal(V1); not mamal(V1).
% herbivore(V1) :- animal(V1); not bird(V1).