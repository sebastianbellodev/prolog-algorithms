/* Step 1:
   Establish knowledge base. */
route(oradea, sibiu, 151).
route(oradea, zerind, 71).
route(zerind, arad, 75).
route(arad, sibiu, 140).
route(arad, timisoara, 118).
route(sibiu, fagaras, 99).
route(sibiu, rimnicu, 80).
route(timisoara, lugoj, 111).
route(lugoj, mechadia, 70).
route(mechadia, dobreta, 75).
route(dobreta, craiova, 120).
route(rimnicu, craiova, 146).
route(craiova, pitesti, 138).
route(fagaras, bucarest, 211).
route(pitesti, bucarest, 101).
route(bucarest, giurgiu, 90).
route(bucarest, urziceni, 85).
route(urziceni, hirsova, 98).
route(urziceni, vaslui, 142).
route(hirsova, eforie, 86).
route(vaslui, iasi, 92).
route(iasi, neamt, 87).

/* Extra:
   Define belongs function. */
belongs(X, [X|_]).
belongs(X, [_|T]):-belongs(X, T).

/* Step 2:
   Establish successors. */
successor(State, Successor, Route, Cost):-
route(State, Successor, Cost),
not(belongs(Successor, Route)).

successor(State, Successor, Route, Cost):-
route(Successor, State, Cost),
not(belongs(Successor, Route)).

/* Successor and Cost are not unified; State and Route are unified.
   successor(oradea, successor, [], Cost)
   State = oradea, successor = [sibiu | zerind],
   Cost = [151 | 71].

   successor(sibiu, successor, [arad], Cost)
   State = sibiu, successor = [fagaras | rimnicu |
   oradea | arad], Cost = [99 | 80 | 151 | 140]. */

/* Extra:
   Define addFinalElement function. */
addFinalElement(X, [], [X]).
addFinalElement(X, [H|T], [H|R]):-addFinalElement(X, T, R).


/* Step 3:
   Establish search by depth engine. */
depth(ActualState, Goal, Solution):-
depth(ActualState, Goal, [ActualState],
0, Solution).

/* Solution = [Route, Cost];
   ActualState = arad, Goal = bucarest,
   Cost = 450,
   Route = [arad, sibiu, fagaras, bucarest]. */

/* Step 3.1:
   Recursion (base case). */
depth(ActualState, ActualState, Route,
Cost, [Route, Cost]).

/* Step 3.2:
   Recursion (recursive case). */
depth(ActualState, Goal, Route, Cost,
Solution):-
/* Step 3.2.1:
   Generate succesor for each branch. */
sucesor(ActualState, Sucesor, Route, SuccessorCost),
/* Step 3.2.2:
   Update successors route list accumulator. */
addFinalElement(Sucesor, Route, NewRoute),
/* Step 3.2.3:
   Update successors cost list accumulator. */
NewCost is Cost + SuccessorCost,
/* Step 3.2.4:
   Recursive call with new route and cost. */
depth(Sucesor, Goal, NewRoute, NewCost,
Solution).
