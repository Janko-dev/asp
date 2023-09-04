
## Choice rules

Choice rules express the notion of having possibly many answer sets as stable models (or none at all). Analogous to finding multiple roots of an algebra equation, `clingo` finds the possible answer sets given some lower and upper bound. The head of a choice rule includes a set of braces with the distinguishing predicates separated by semi-colons. For instance, the choice rule
```prolog
{ p(a); q(b) }.
```
describes all possible ways to choose which of the atoms `p(a)`, `q(b)` to include in the model. Since there are 4 different combinations to choose from a set of 2 elements, `clingo` produces 4 stable models. These are 
```
Answer: 1

Answer: 2
q(b)
Answer: 3
p(a)
Answer: 4
p(a) q(b)
```
### upper-lower bound
To introduce a lower bound on the possible elements in the set, we can denote the lower bound before the opening brace, i.e., `1 { p(a); q(b) } .`. This indicates a form of constraint, that is, we include only those atoms in the answer set such that the set has at least one element. This results in:
```
Answer: 1
p(a)
Answer: 2
q(b)
Answer: 3
q(b) p(a)
```
To introduce an upper bound on the possible stable models, we denote the bound after the closing brace, i.e., `{ p(a); q(b) } 1.`. This indicates that we include only those atoms in the answer set such that the set has at most 1 element. This results in:
```
Answer: 1

Answer: 2
p(a)
Answer: 3
q(b)
```

### Variables in choice rules
Up until now the choice rule contained only atoms. However, we can also include variables in the choice rule which will get replaced by the atoms during grounding. Consider:
```prolog
{ p(X); q(X) } = 1 :- X = 1..n.
```
let n equal 2, then this program produces 4 stable models, each containing a combination of predicates p/1, q/1. This program thus has $2^n$ stable models, which effectively partition the set `{1..n}` into subsets of p/1 and q/1. 

Using variables in choice rules, we can also bind variables locally. For instance,
```prolog
person(a; b; c; d; e; f).
{ elected(x) : person(X) } = 3.
```
describes the atoms `person(X)` where `X` $\in$ `{a, b, c, d, e, f}`, and the choice rule in which we bind `person(X)` to `elected(X)` for the lower and upper bound of 3. The number of stable models is equivalent to the operation of `6 choose 3` in combinatorics. 

## Constraints

Constraints are additional rules that eliminate stable models for which the constraint is violated. A constraint is a rule with an empty head, e.g.,
```prolog
:- p(1)
```
in the logic program:
```prolog
1 { p(1..3) } 2 .
:- p(1)
```
which produces the 6 stable models that `1 { p(1..3) } 2 .` would produce, i.e., 
1. `{p(1)}`, 
2. `{p(2)}`, 
3. `{p(3)}`, 
4. `{p(1), p(2)}`, 
5. `{p(1), p(3)}`, 
6. `{p(2), p(3)}`, 

minus the stable models that contain the predicate `p(1)` (which are 1, 4, and 5, in the listing above). As a result, only 3 stable models are yielded, i.e., `{p(3)}`, `{p(2)}`, `{p(2), p(3)}`.

Therefore, it is important to understand that a constaint expresses which predicate form **not** to include in the answers. Nevertheless, we can reverse this by prepending `not` to the constraint, which will change the semantic to instead include the predicate in the constraint. 
```prolog
1 { p(1..3) } 2 .
:- not p(1)
```
This yields the stable models `{p(1)}`, `{p(1), p(2)}`, `{p(1), p(3)}`. 

### Pair vs Combination of constraints

If a constraint has multiple predicates, i.e., `:- p(1), p(2)`, its meaning is equivalent to 
$$
    \neg (p(1) \land p(2))
$$
which will filter out any stable model that adheres to this conjunction. In other words, the number of produced stable models is 5, instead of 6, as `{p(1), p(2)}` is excluded. 

If instead, the program has a sequence of constraints, e.g., 
```prolog
1 { p(1..3) } 2 .
:- p(1).
:- p(2).
```
then the stable models containing either `p(1)` or `p(2)` are filtered out, which, in this program, results in a single stable model. That is, the answer set `{p(3)}`. 

