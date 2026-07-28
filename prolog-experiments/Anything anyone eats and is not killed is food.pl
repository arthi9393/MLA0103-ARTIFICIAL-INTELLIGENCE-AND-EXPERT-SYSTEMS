food(X) :-
    eats(Y, X),
    \+ killed(Y).

eats(john, apple).
eats(raja, rice).
eats(priya, vegetable).

killed(tiger).
