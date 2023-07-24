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
successor(State, successor, Route, Cost):-
route(State, successor, Cost),
not(belongs(successor, Route)).

successor(State, successor, Route, Cost):-
route(successor, State, Cost),
not(belongs(successor, Route)).

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

/* Extra:
   Define concatElement function. */
concatElement([],L,L).
concatElement([X|T],L,[X|C]):-concatElement(T,L,C).

/* Step 3:
   Establish search by amplitude engine. */

/* Step 3.1:
   Extend route (generate branch)
   Recursion (base case). */
extendRoute(_, _, [], []):-!.

/*
   extendRoute(ActualState, Route, SuccessorsList, Solution).
   extendRoute(sibiu, [arad], [oradea, fagaras, rimnicu], Solution)
   Solution not unified.
   Solution = [[arad, sibiu], [arad, sibiu], [arad, sibiu]]. */


/* Step 3.2:
   Recursion (recursive case). */
extendRoute(ActualState, Route, [_|TSuccessor], [AuxRoute|TSolution]):-

/* Step 3.2.1:
   Update successors route list accumulator. */
addFinalElement(ActualState, Route, AuxRoute),
/* Step 3.2.2:
   Recursive call. */
extendRoute(ActualState, Route, TSuccessor, TSolution).

/* Step 4
   Generate costs. */

/* Step 4.1:
   Extend costs (generate branch costs)
   Recursion (base case). */
extendCosts(_, [], []):-!.

/*
   extendCosts(ActualStateCost, SuccessorsCostsList, Solution).

   extendCosts(140, [151, 99, 80], Solution)
   Solution not unified.
   Solution = [291, 239, 220]. */


/* Step 4.2:
   Recursion (recursive case). */
extendCosts(ActualStateCost, [HCosTSuccessor|TCosTSuccessor], [AuxCost| SurplusCost]):-
AuxCost is ActualStateCost + HCosTSuccessor,
extendCosts(ActualStateCost, TCosTSuccessor, SurplusCost).

/* Step 5
   Search by amplitude.
*/
amplitude(InitialState, Goal, Solution):-
amplitude([InitialState], Goal, [[]], [0], Solution),!.
/* 
   Receives InitialState, Goal, Routes, Costs, Solution.
*/

/* Step 5.1
   Recursion (base case).
*/

amplitude([Goal|_], Goal, [HRoutes|_], [HCosts|_], [AuxRoute,HCosts]):-
addFinalElement(Goal, HRoutes, AuxRoute).

/* Step 5.2
   Recursion (general case).
*/
amplitude([HQueue|TQueue], Goal, [HRoutes|TRoutes], [HCosts|TCosts], Solution):-

/* Step 5.2.1
   Generate succesor list using bagof.
*/
bagof(successor, Cost^successor(HQueue, successor, HRoutes, Cost), SuccessorBag),

/* Use of bagof predicate.
   Pair searching:
   bagof([X,Y], route(X,Y), Bag)

   Variable searching:
   bagof(X, Y^route(X,Y), Bag).

   For the purpose of this exercise:
   bagof(successor, Cost^successor(ActualState, successor, [], Cost), Bag).
*/

/* Step 5.2.2
 * Generate cost list using bagof.
*/
bagof(Cost, successor^successor(HQueue, successor, HRoutes, Cost), BagCosts),

/* Step 5.2.3
   Queu successors from queu head y un-queu queu head.
   Generate new headless queu for next recursion.
*/
concatElement(TQueue, SuccessorBag, NewQueu),

/* Step 5.2.4
   Extend routes for each succesor.
*/
extendRoute(HQueue, HRoutes, SuccessorBag, NewSuccessorRoute),

/* Step 5.2.5
   NewSuccessorRoute is useful for next recursion.
*/
concatElement(TRoutes, NewSuccessorRoute, NewRoutes),

/* Step 5.2.6
   Extend costs for each succesor.
*/
extendCosts(HCosts, BagCosts, SuccessorsCosts),

/* Step 5.2.7
   NewRoutes is useful for next recursion.
*/
concatElement(TCosts, SuccessorsCosts, NewCosts),

amplitude(NewQueu, Goal, NewRoutes, NewCosts, Solution).

amplitude([_|TQueue], Goal, [_|TRoutes], [_|TCosts], Solution):-
amplitude(TQueue, Goal, TRoutes, TCosts, Solution).
