pair(List, Solution):-pair(List, [], Solution),!.

pair([], List, List).
pair([H|T], List, Solution):-
mod(H,2)=:=0,
addFinalElement(List, H, FilteredList),
pair(T, FilteredList, Solution).

pair([H|T], List, Solution):-
not(mod(H,2)=:=0),
pair(T, List, Solution).

addFinalElement(X, [], [X]).
addFinalElement(X, [H|T], [H|L]):-addFinalElement(X, T, L).
