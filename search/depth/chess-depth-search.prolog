/* Step 1:
   Establish knowledge base. */
:-dynamic cell/2.

/* Step 1.1:
   Generate abscissa values per each ordinate. */
abscissa(X, X, _).
abscissa(N, X, Y):-assert(cell(X, Y)), XN is X + 1, abscissa(N, XN, Y).

/* Step 1.2:
   Generate ordinate values. */
ordinate(N, _, N).
ordinate(N, X, Y):- abscissa(N, X, Y), YN is Y + 1, ordinate(N, X, YN).

/* Step 1.2:
   Generate board. */
principal(N):-retractall(cell(_,_)), N > 0, ordinate(N,0,0),!.

/* Extra:
   Define belongs function. */
belongs(X, [X|_]).
belongs(X, [_|T]):-belongs(X, T).

/* Step 2:
   Establish successors. */
successor(X, Y,[]):-
cell(X, Y).

successor(X, Y, [H|T]):-
cell(X, Y),
not(belongs(Y, [H|T])),
XPlusOne is H + 1,
not(XPlusOne == Y),
XMinusOne is H - 1,
not(XMinusOne == Y).

/* Extra:
   Define concatElement function. */
concatElement([],L,L).
concatElement([X|T],L,[X|C]):-concatElement(T,L,C).

/* Step 3:
   Establish search by depth engine. */
queens(N, Solution):-principal(N), queens(0, N, [], [], Solution).

/* Step 3.1:
   Extend route (generate branch)
   Recursion (base case). */
queens(Limit, Limit, _, List, List).

/* Step 3.2:
   Recursion (recursive case). */
queens(X, Limit, Ac, List, Solution):-
/* Step 3.2.1:
   Update successors route list accumulator. */
successor(X, Y, Ac),
/* Step 3.2.2:
   Update successors route list accumulator. */
concatElement(List, [[X,Y]], NewList),
/* Step 3.2.3:
   Update abscissa values. */
Abscissa is X + 1,
/* Step 3.2.4:
   Recursive call with new ordinate counter, as well as new ordinate pairs list. */
queens(Abscissa, Limit, [Y|Ac], NewList, Solution).
