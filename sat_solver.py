
import copy

class Lit:
    def __init__(self, name: str, positive: bool):
        self.name = name
        self.positive = positive
    
    def __repr__(self) -> str:
        return f"{'' if self.positive else '-'}{self.name}"

class Formula:

    def __init__(self, clauses = []) -> None:
        self.clauses = set()
        for clause in clauses:
            clause_set = frozenset([
                Lit(lit[1:], False) if lit[0] == "-" 
                else Lit(lit, True) 
                for lit in clause
            ])
            self.clauses.add(clause_set)

# Compute consequences of F0 and I0
# add consequences to I and use them to simplify F
def cons(F0: Formula, I0: set):
    F = copy.deepcopy(F0)
    I = copy.deepcopy(I0)

    # while there is a unary clause 
    while x := [c for c in F.clauses if len(c) == 1]:
        lit, = x[0]
        # remove from F all clauses containing lit
        F.clauses = {c for c in F.clauses if lit not in c}
        # remove from F all occurrences of -lit (negative lit)
        F.clauses = {frozenset([l for l in c if not (l.name == lit.name and l.positive != lit.positive)]) for c in F.clauses}
        I.add(lit)

    # if contradiction: {} in F, return original F0, I0
    if frozenset() in F.clauses:
        return (F0, I0, False)
    else:
        return (F, I, True)

def sat(I0, F0: Formula):
    F = copy.deepcopy(F0)
    I = copy.deepcopy(I0)
    
    F, I, X = cons(F, I)
    
    if not X:
        return (I0, False)
    
    # if F = {}, then every element of F is satisfiable
    if len(F.clauses) == 0:
        return (I, True)
    
    # make non-deterministic choice of yet undefined variable p of F
    undefs = {l for c in F.clauses for l in list(iter(c)) if c} - I
    p = next(iter(undefs))

    # call sat again with union of F and p
    F1 = Formula()
    F1.clauses = F.clauses.union({frozenset([p])})
    (I, X) = sat(I, F1)

    if X:
        return (I, True)
    else:
        p_neg = Lit(p.name, False)
        F1 = Formula()
        F1.clauses = F.clauses.union({frozenset([p_neg])})
        return sat(I, F1)

# formula; X1 & (-X1 | X2 | X3) & (-X1 | X4)
f = Formula([["X1"], ["-X1", "X2", "X3"], ["-X1", "X4"]])

# f = Formula([["X1", "X2"], ["-X2"]])

I, X = sat(set(), f)

# print partial interpretation I
print(I, X)