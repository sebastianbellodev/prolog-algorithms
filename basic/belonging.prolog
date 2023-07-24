belongs(X, [X|_]).
belongs(X, [_|T]):-belongs(X,T).

main():- read(X), read(Y), belongs(X,Y), write("true").
main():- write("false").
