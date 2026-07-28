has(monkey, box).
has(monkey, banana).

can_get_banana :-
    has(monkey, box),
    has(monkey, banana).
