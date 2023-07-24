addFinalElement(X, [], [X]).
addFinalElement(X, [H|T], [H|L]):-addFinalElement(X, T, L).

main():- read(X), read(L), addFinalElement(X, L, R), write(R).
