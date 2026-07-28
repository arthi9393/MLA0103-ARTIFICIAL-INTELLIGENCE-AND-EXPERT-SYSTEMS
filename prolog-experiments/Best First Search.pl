edge(a,b).
edge(a,c).
edge(b,d).
edge(b,e).
edge(c,f).
edge(e,g).

best_first(X,Y):-
    edge(X,Y).

best_first(X,Y):-
    edge(X,Z),
    best_first(Z,Y).
