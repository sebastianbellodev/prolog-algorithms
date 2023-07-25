/* Step 1:
   Establish knowledge base. */
adjacent(1, 2).
adjacent(2, 3).
adjacent(3, 4).
adjacent(3, 5).
adjacent(4, 6).
adjacent(5, 6).
adjacent(5, 7).
adjacent(6, 8).
adjacent(7, 8).
adjacent(8, 9).
adjacent(9, 10).
adjacent(9, 13).
adjacent(10, 11).
adjacent(11, 12).
adjacent(11, 14).
adjacent(12, 15).
adjacent(13, 16).
adjacent(14, 15).
adjacent(15, 18).
adjacent(16, 17).
adjacent(16, 19).
adjacent(17, 20).
adjacent(18, 22).
adjacent(19, 20).
adjacent(20, 21).
adjacent(21, 22).

:- dynamic treasure/1.
:- dynamic hole/1.

/* Extra:
   Define belongs function. */
belongs(X, [X|_]).
belongs(X, [_|T]):-belongs(X, T).

/* Step 2:
   Establish successors. */
Successor(State, Successor, Route):-
adjacent(State, Successor),
not(belongs(Successor, Route)),
not(hole(Successor)).

successor(State, Successor, Route):-
adjacent(Successor, State),
not(belongs(Successor, Route)),
not(hole(Successor)).

/* Extra:
   Define addFinalElement function. */
addFinalElement(X, [], [X]).
addFinalElement(X, [H|T], [H|R]):-addFinalElement(X, T, R).

/* Step 3:
   Establish search by amplitude engin to get sword. */
search(Solution):-search(1, [1], Solution).

/* Step 3.1:
   Extend route (generate branch)
   Recursion (base case). */
search(ActualState, Route, Route):-treasure(ActualState).

/* Step 3.2:
   Recursion (recursive case). */
search(ActualState, Route, Solution):-
/* Step 3.2.1:
   Update successors route list accumulator. */
Successor(ActualState, Successor, Route),
/* Step 3.2.2:
   Update successors route list accumulator. */
addFinalElement(Successor,Route,NewRoute),
/* Step 3.2.3:
   Recursive call with new route and cost. */
search(Successor, NewRoute, Solution).

main():- read(X), read(Y), assert(treasure(X)), assert(hole(Y)), search(R),
write(R).
main():- write("false").
