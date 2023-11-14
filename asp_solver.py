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

def reduct(prg: "set[Rule]", I: "set[Lit]"):
    red_prog = set()
    for r in prg:
        if any([Lit.from_str(b.name) in I for b in r.body if not b.positive]):
            continue
        red_prog.add(Rule(r.head.name, {b.name for b in r.body if b.positive}))
    return red_prog

def expand(prg: "set[Rule]", L: "set[Lit]", U: "set[Lit]"):
    while True:
        L0 = copy.deepcopy(L)
        U0 = copy.deepcopy(U)
        L = L0.union(least(reduct(prg, U0)))
        U = U0.intersection(least(reduct(prg, L0)))
        if not L.issubset(U): 
            print("FAILURE")
            return (L, U)
        if L == L0 and U == U0: break

    return (L, U)

prg = {
    Rule("a", {}),
    Rule("b", {"a", "not c"}),
    Rule("d", {"b", "not e"}),
    Rule("e", {"not d"}),
}

Alphabet = {"a", "b", "c", "d", "e"}
L = set()
U = {Lit.from_str(a) for a in Alphabet}

stable_models = []

def solve(prg, L, U):
    global stable_models
    L, U = expand(prg, L, U)                # propagate
    if not L.issubset(U):                   # failure
        print("FAILURE")
        return
    # print(L, U)
    if L == U: stable_models.append(L)      # success
    else :
        undef_atoms = U.difference(L)
        a = undef_atoms.pop()               # choice
        solve(prg, L.union({a}), U)         #   repeat solve(L+a, U)
        solve(prg, L, U.difference({a}))    #   repeat solve(L, U-a)

solve(prg, L, U)
print(stable_models)
