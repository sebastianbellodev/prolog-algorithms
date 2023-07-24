directRoute(xalapa, coatepec).
directRoute(coatepec, allende).
directRoute(allende, xico).
directRoute(banderilla, xalapa).
directRoute(perote, vigas).
directRoute(vigas, cruz_blanca).
directRoute(puebla,perote).

route(X, Y):-directRoute(X, Y).
route(X, Y):-directRoute(Y, X).
route(X, Y):-directRoute(Y, Z),route(Z, X).
route(X, Y):-directRoute(X, Z),route(Z, Y).

main():- read(X), read(Y), route(X, Y), write("true").
main():- write("false").
