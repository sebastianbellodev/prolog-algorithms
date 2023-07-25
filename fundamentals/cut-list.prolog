cut(List, Solution):-cut(List, [], Solution).

cut([], AuxList, AuxList).
cut([H|T], AuxList, Solution):-
addFinalElement(AuxList, H, ResultList),
cut(T, ResultList, Solution).

cut([[H|T]|R], AuxList, Solution):-
addFinalElement(AuxList, H, ResultList),
concatElement(T, R, ConcatList),
cut(ConcatList, ResultList, Solution).

addFinalElement([], X, [X]).
addFinalElement([H|T], X, [H|R]):-addFinalElement(T, X, R).

concatElement([], List, List).
concatElement([H|T], List, [H|R]):-concatElement(T, List, R).
