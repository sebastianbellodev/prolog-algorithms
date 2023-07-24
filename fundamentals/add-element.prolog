addElement(X, L, [X|L]).

main():- read(X), read(L), addElement(X, L, R), write(R).
