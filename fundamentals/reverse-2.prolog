reverse(List, Solution):-reverse(List, [], Solution).

reverse([], List, List).
reverse([H|T], List, Solution):-
reverse(T, ResultList, Solution),
concatElement(H, List, ResultList).

concatElement([], L, L).
concatElement([X|T], L, [X|C]):-concatElement(T, L, C).
