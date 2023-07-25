add(Summand, List, Solution):-add(Summand, List, [], Solution),!.
add(_, [], Answer, Answer).
add(Summand, [H|T], Answer, Solution):-
addFinalElement(Answer, Sum, SumList),
Sum is Summand + H,
add(Summand, T, SumList, Solution).

addFinalElement([], Element, [Element]).
addFinalElement([H|T], Element, [H|R]):-addFinalElement(T, Element, R).
