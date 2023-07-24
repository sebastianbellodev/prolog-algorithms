father(james, mac).
father(justin, james).
father(steve, justin).
father(aaron, olivia).
mother(maria, mac).
mother(olivia, james).
mother(taylor, justin).
mother(hailee, olivia).

ancestor(X, Y):-father(X, Y).
ancestor(X, Y):-mother(X, Y).
ancestor(X, Y):-father(X, Z),ancestor(Z, Y).
ancestor(X, Y):-mother(X, Z),ancestor(Z, Y).


main():- read(X), read(Y), antepasado(X, Y), write("true").
main():- write("false").
