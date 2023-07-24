reverseSet(L, R):-reverseSet(L, [], R).
reverseSet([], Ac, Ac).
reverseSet([H|T], Ac, R):-reverseSet(T, [H|Ac], R).

main():-read(L), reverseSet(L, R), write(R).
