bird(parrot).
bird(crow).
bird(sparrow).
bird(penguin).
bird(ostrich).

cannot_fly(penguin).
cannot_fly(ostrich).

can_fly(X) :-
    bird(X),
    \+ cannot_fly(X).
