has_fever(raja).
has_cough(raja).

flu(X) :-
    has_fever(X),
    has_cough(X).
