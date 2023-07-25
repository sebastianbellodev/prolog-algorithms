index(Element, List, Solution):-
index(Element, List, 0, [], Solution).

index(_, [], _, AcList, AcList).
index(Element, [H|T], Counter, AuxList, Solution):-
H == Element,
Index is Counter + 1,
addFinalElement(AuxList, Index, AcList),
index(Element, T, Index, AcList, Solution).

index(Element, [H|T], Counter, AuxList, Solution):-
not(H == Element),
Index is Counter + 1,
index(Element, T, Index, AuxList, Solution).


addFinalElement([], X, [X]).
addFinalElement([H|T], X, [H|R]):-addFinalElement(T, X, R).

main():- read(X), read(Y), index(X, Y, Z), write(Z).
