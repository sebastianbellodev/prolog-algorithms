greater([H|T], Solution):-greater([H|T], H, Solution),!.

greater([], Greater, Greater).
greater([H|T], Greater, Solution):-
H > Greater,
greater(T, H, Solution).

greater([H|T], Greater, Solution):-
H =< Greater,
greater(T, Greater, Solution).

main():-read(L), greater(L,R), write(R).
