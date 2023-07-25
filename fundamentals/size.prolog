size(List, Solution):-size(List, 0, Solution),!.
size([], Counter, Counter).
size([_|T], Counter, Solution):-
Ac is Counter + 1,
size(T, Ac, Solution).
