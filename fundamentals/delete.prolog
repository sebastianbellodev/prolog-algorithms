deleteElement(_, [], []).
deleteElement(X, [X|T], L):-deleteElement(X, T, L).
deleteElement(X, [H|T], [H|C]):-deleteElement(X, T, C).

main():-  read(X), read(L),  deleteElement(X, L, R), write(R).
