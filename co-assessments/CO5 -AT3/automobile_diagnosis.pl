% Automobile Fault Diagnosis Expert System
% Course: Artificial Intelligence and Expert Systems
% Problem: Automobile Fault Diagnosis

% -------------------------
% FACTS
% -------------------------

overheating(car1).
low_coolant(car1).
warning_light(car1).

starting_failure(car2).
weak_battery(car2).

abnormal_noise(car3).
low_oil(car3).

low_mileage(car4).
high_fuel_consumption(car4).

% -------------------------
% DIAGNOSIS RULES
% -------------------------

fault(Car, cooling_system_failure) :-
    overheating(Car),
    low_coolant(Car).

fault(Car, engine_malfunction) :-
    warning_light(Car),
    overheating(Car).

fault(Car, battery_problem) :-
    starting_failure(Car),
    weak_battery(Car).

fault(Car, lubrication_problem) :-
    abnormal_noise(Car),
    low_oil(Car).

fault(Car, fuel_system_problem) :-
    low_mileage(Car),
    high_fuel_consumption(Car).
