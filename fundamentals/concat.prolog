concatElement([], L, L).
concatElement([X|T], L, [X|C]):-concatElement(T, L, C).

main():- read(X), read(L), concatElement(X, L, R), write(R).
