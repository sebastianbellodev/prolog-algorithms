push(Element, List, Solution):-push(Element, List, [], Solution),!.

push(_, [], AuxList, AuxList).

push(Element, [H|T], AuxList, Solution):-
Element > H,
concat(AuxList, [H], AcList),
push(Element, T, AcList, Solution).

push(Element, [H|T], AuxList, Solution):-
Element =< H,
concat([Element, H], T, AcList),
concat(AuxList, AcList, ResultList),
push(Element, [], ResultList, Solution).

concat([], List, List).
concat([H|T], List, [H|R]):-concat(T, List, R).

main():-read(X), read(Y), push(X,Y,R), write(R).
