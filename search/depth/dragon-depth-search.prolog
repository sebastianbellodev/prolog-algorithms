/* Step 1:
   Establish knowledge base. */
adjacent(1, 2).
adjacent(2, 3).
adjacent(3, 5).
adjacent(3, 4).
adjacent(5, 6).
adjacent(4, 6).
adjacent(6, 7).
adjacent(6, 8).
adjacent(7, 9).
adjacent(8, 9).
adjacent(9, 10).
adjacent(10, 11).

:- dynamic sword/1.
:- dynamic dragon/1.

/* Extra:
   Define belongs function. */
belongs(X, [X|_]).
belongs(X, [_|T]):-belongs(X, T).

/* Step 2:
   Establish successors. */
successor(State, Successor, Route):-
adjacent(State, Successor),
not(belongs(Successor, Route)),
not(dragon(Successor)).

successor(State, Successor, Route):-
adjacent(Successor, State),
not(belongs(Successor, Route)),
not(dragon(Successor)).

heir(State, Successor, Route):-
adjacent(State, Successor),
not(belongs(Successor, Route)),
not(sword(Successor)).

heir(State, Successor, Route):-
adjacent(Successor, State),
not(belongs(Successor, Route)),
not(sword(Successor)).

/* Extra:
   Define addFinalElement function. */
addFinalElement(X, [], [X]).
addFinalElement(X, [H|T], [H|R]):-addFinalElement(X, T, R).

/* Extra:
   Define concatElement function. */
concatElement([], L, L).
concatElement([X|T], L, [X|C]):-concatElement(T, L, C).

/* Step 3:
   Establish search by depth engine to get sword. */
search(Solution):-swordSearch(1, [1], Solution).

/* Step 3.1:
   Extend route (generate branch)
   Recursion (base case). */
swordSearch(ActualState, Route, Solution):-sword(ActualState),
concatElement(Route, Answer, Solution),
searchDragon(ActualState, [], Answer).

/* Step 3.2:
   Recursion (recursive case). */
swordSearch(ActualState, Route, Solution):-
/* Step 3.2.1:
   Update successors route list accumulator. */
Successor(ActualState, Successor, Route),
/* Step 3.2.2:
   Update successors route list accumulator. */
addFinalElement(Successor,Route,NewRoute),
/* Step 3.2.3:
   Recursive call with new route and cost. */
swordSearch(Successor, NewRoute, Solution).

/* Step 3.1:
   Extend route (generate branch)
   Recursion (base case). */
searchDragon(ActualState,Route,Route):-dragon(ActualState).

/* Step 3.2:
   Recursion (recursive case). */
searchDragon(ActualState, Route, Solution):-
/* Step 3.2.1:
   Update successors route list accumulator. */
heir(ActualState, Successor, Route),
/* Step 3.2.2:
   Update successors route list accumulator. */
addFinalElement(Successor, Route, NewRoute),
/* Step 3.2.3:
   Recursive call with new route and cost. */
searchDragon(Successor, NewRoute, Solution).

main():- read(X), read(Y), assert(sword(X)), assert(dragon(Y)),
search(R), write(R).
main():- write("false").
