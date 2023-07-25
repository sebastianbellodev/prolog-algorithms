pass(List, Solution):-pass(List, [], Solution),!.

pass([], Passed, Passed).
pass([H|T], AuxList, Solution):-
H > 6,
addFinalElement(AuxList, H, Passed),
pass(T, Passed, Solution).

pass([H|T], AuxList, Solution):-
H < 6,
pass(T, AuxList, Solution).

addFinalElement(X, [], [X]).
addFinalElement(X, [H|T], [H|L]):-addFinalElement(X, T, L).
