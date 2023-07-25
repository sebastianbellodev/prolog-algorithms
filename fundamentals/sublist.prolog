sublist(_, []):-!.
sublist([H|T], [H|R]):-sublist(T, R),!.
sublist([_|T], List):-sublist(T, List),!.
