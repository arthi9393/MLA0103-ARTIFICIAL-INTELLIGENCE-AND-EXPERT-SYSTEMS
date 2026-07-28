has_fever(john).
has_cough(john).

disease(X, flu) :-
    has_fever(X),
    has_cough(X).
