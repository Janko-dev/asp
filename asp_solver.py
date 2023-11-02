import copy

class Lit:
    def __init__(self, name: str, positive: bool):
        self.name = name
        self.positive = positive
    
    def __repr__(self) -> str:
        return f"{'' if self.positive else 'not '}{self.name}"
    
    def __eq__(self, other) -> bool:
        return isinstance(other, Lit) and self.name == other.name and self.positive == other.positive

    def __hash__(self) -> int:
        return hash((self.name, self.positive))

    def from_str(lit: str):
        lit = lit.strip().split(" ")
        if len(lit) == 2: 
            return Lit(lit[1], False)
        else:
            return Lit(lit[0], True)

class Rule:
    def __init__(self, head: str, body={}) -> None:
        self.head = Lit.from_str(head)
        self.body = {Lit.from_str(b) for b in body}

    def __repr__(self) -> str:
        return f"{self.head} :- {', '.join(b.__repr__() for b in self.body)}."

    def falsified_by(self, I) -> bool:
        return any([
            b.name == i.name and b.positive != i.positive 
            for b in self.body 
            for i in I
        ])
    
    def remove_lit_from_body(self, I):
        self.body = {b for b in self.body if b not in I}

    def __hash__(self) -> int:
        return hash((self.head, frozenset(self.body)))

def lower_bound(prg0: "set[Rule]", I0: set) -> (set, set, bool):
    I = copy.deepcopy(I0)
    prg = copy.deepcopy(prg0)
    while True:
        T = copy.deepcopy(I)

        prg = {r for r in prg if not r.falsified_by(I)}
        for r in prg: r.remove_lit_from_body({i for i in I if i.positive == False})

        for r in prg:
            # rule 1:
            if r.body.issubset(I): 
                I.add(r.head)
            

        if T == I: break
    
    # if consistent
    return (prg, I, True)

def solver(I0, prg0) -> (set, bool):
    I = copy.deepcopy(I0)
    prg = copy.deepcopy(prg0)
    (prg, I, X) = lower_bound(prg, I)
    for r in prg: print(r)
    print(I)


def T_pi(prg: "set[Rule]", A: "set[Lit]"):
    for r in prg:
        if r.body.issubset(A):
            A.add(r.head)
    return A

def least(prg):
    X = set()
    X0 = set()
    while True:
        X0 = copy.deepcopy(X)
        X = T_pi(prg, X)

        if X == X0: break
    return X

prg = {
    Rule("p", {}),
    Rule("q", {"p"}),
    Rule("r", {"p", "q"}),
}

A = least(prg)
print(A)
# for r in prg: print(r)

# solver(set(), prg)