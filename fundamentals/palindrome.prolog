palindrome(List):-
reverse(List, Reverse),
List == Reverse.

reverse(List, Solution):-reverse(List, [], Solution).

reverse([], List, List).
reverse([H|T], List, Solution):-
reverse(T, AuxList, Solution),
concatElement([H], List, AuxList).


concatElement([], List, List).
concatElement([H|T], List, [H|R]):-concatElement(T, List, R).
