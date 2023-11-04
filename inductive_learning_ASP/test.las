% background B
lego_builder(alice).
lego_builder(bob). 
estate_agent(claire).
estate_agent(dave).

enjoys_lego(alice).
enjoys_lego(claire).

% search space SM
#modeh(happy(var(t1))).
#modeb(3, lego_builder(var(t1))).
#modeb(3, estate_agent(var(t1))).
#modeb(3, enjoys_lego(var(t1))).

% positive examples E+
#pos({happy(alice)}, {}).

% negative examples E-
#neg({happy(bob)}, {}).
#neg({happy(claire)}, {}).
#neg({happy(dave)}, {}).
