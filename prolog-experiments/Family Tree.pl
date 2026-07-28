male(john).
male(david).
male(peter).

female(mary).
female(linda).
female(susan).

parent(john,david).
parent(mary,david).
parent(john,linda).
parent(mary,linda).
parent(david,peter).
parent(susan,peter).

father(X,Y) :-
    parent(X,Y),
    male(X).

mother(X,Y) :-
    parent(X,Y),
    female(X).

grandparent(X,Y) :-
    parent(X,Z),
    parent(Z,Y).
