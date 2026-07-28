% Facts
man(marcus).
pompeian(marcus).
ruler(caesar).
assassinate(marcus, caesar).

% Rules
roman(X) :-
    pompeian(X).

people(X) :-
    man(X).

% Romans are either loyal or hate Caesar
loyal(X, caesar) :-
    roman(X),
    people(X).

hates(X, caesar) :-
    roman(X),
    \+ loyal(X, caesar).

% People try to assassinate only rulers they are not loyal to
not_loyal(X, Y) :-
    assassinate(X, Y),
    ruler(Y),
    \+ loyal(X, Y).
