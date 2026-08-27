/* ============================================================
   AUTOMOBILE FAULT DIAGNOSIS EXPERT SYSTEM
   Language : SWI-Prolog
   Purpose  : Identify probable vehicle faults from symptoms
              (engine noise, starting problems, warning
              indicators, abnormal vibration, reduced mileage)
              using production rules, with both FORWARD
              CHAINING (data-driven) and BACKWARD CHAINING
              (goal-driven) inference engines.
   ============================================================ */

:- dynamic(symptom/1).          % observed symptom facts
:- dynamic(fault/1).            % derived fault conclusions
:- dynamic(known/2).            % memoised answers for backward chaining: known(Symptom,yes/no)
:- dynamic(fired/1).            % rules that fired, for explanation trace

/* ------------------------------------------------------------
   STAGE 1-2 : DOMAIN MODEL / SYMPTOM VOCABULARY
   ------------------------------------------------------------
   engine_knocking, engine_squealing, engine_grinding,
   engine_ticking, engine_hissing            -- engine noise
   no_crank, cranks_no_start, hard_start,
   stalls_after_start, slow_engine_crank,
   clicking_sound_on_start                   -- starting problems
   check_engine_light, battery_light,
   oil_light, temp_light                     -- warning indicators
   idle_vibration, high_speed_vibration,
   braking_vibration, steering_vibration      -- abnormal vibration
   reduced_mileage, black_smoke, white_smoke,
   fuel_smell, rough_idle, dim_headlights,
   low_oil_level, engine_overheating          -- other observations
   ------------------------------------------------------------ */

/* ============================================================
   STAGE 3 : KNOWLEDGE BASE - PRODUCTION RULES (IF-THEN)
   Each fault rule is written as:
        fault(Name) :- Condition1, Condition2, ...
   Conditions are symptom/1 facts OR other fault/1 conclusions,
   which allows multi-level (chained) inference.
   ============================================================ */

% NOTE: production rules are written under rule/1. fault/1 stays a
% pure dynamic FACT store, holding only conclusions that an
% inference engine has actually derived/asserted. Keeping the two
% separate lets forward chaining tell "provable-by-rule" apart
% from "already-derived-and-recorded" (needed for its fixpoint
% termination test, \+ fault(F)).

% R1: Weak / discharged battery
rule(weak_battery) :-
    symptom(dim_headlights),
    symptom(slow_engine_crank),
    symptom(no_crank).

% R2: Faulty starter motor
rule(faulty_starter_motor) :-
    symptom(clicking_sound_on_start),
    symptom(no_crank).

% R3: Faulty alternator
rule(faulty_alternator) :-
    symptom(battery_light),
    symptom(dim_headlights),
    symptom(stalls_after_start).

% R4: Worn spark plugs
rule(worn_spark_plugs) :-
    symptom(rough_idle),
    symptom(hard_start),
    symptom(check_engine_light).

% R5: Clogged fuel injector
rule(clogged_fuel_injector) :-
    symptom(reduced_mileage),
    symptom(black_smoke),
    symptom(rough_idle).

% R6: Faulty fuel pump
rule(faulty_fuel_pump) :-
    symptom(cranks_no_start),
    symptom(fuel_smell).

% R7: Worn timing belt
rule(worn_timing_belt) :-
    symptom(engine_ticking),
    symptom(check_engine_light),
    symptom(stalls_after_start).

% R8: Wheel misalignment
rule(wheel_misalignment) :-
    symptom(steering_vibration),
    symptom(high_speed_vibration).

% R9: Worn engine mounts
rule(worn_engine_mounts) :-
    symptom(idle_vibration),
    symptom(engine_knocking).

% R10: Faulty oxygen sensor
rule(faulty_oxygen_sensor) :-
    symptom(reduced_mileage),
    symptom(check_engine_light),
    symptom(black_smoke).

% R11: Clogged air filter
rule(clogged_air_filter) :-
    symptom(reduced_mileage),
    symptom(rough_idle),
    symptom(hard_start).

% R12: Worn brake rotor
rule(worn_brake_rotor) :-
    symptom(braking_vibration),
    symptom(engine_squealing).

% R13: Low engine oil
rule(low_engine_oil) :-
    symptom(oil_light),
    symptom(low_oil_level).

% R14: Overheating cooling system
rule(overheating_cooling_system) :-
    symptom(temp_light),
    symptom(engine_overheating),
    symptom(white_smoke).

% R15: Worn CV joint
rule(worn_cv_joint) :-
    symptom(high_speed_vibration),
    symptom(engine_grinding).

% ---- Second-level (meta) production rule: demonstrates
% ---- chaining over DERIVED facts, not just raw symptoms.
% R16: Electrical system failure (derived from two other faults)
rule(electrical_system_failure) :-
    fault(weak_battery),
    fault(faulty_alternator).

/* ============================================================
   STAGE 4a : ADVICE / ACTION PRODUCTION RULES
   IF fault(X) THEN recommend(Action)
   ============================================================ */
recommend(weak_battery,               'Charge or replace the battery; inspect terminals for corrosion.').
recommend(faulty_starter_motor,       'Inspect/replace the starter motor and check its wiring.').
recommend(faulty_alternator,          'Test alternator output; replace if charging voltage is low.').
recommend(worn_spark_plugs,           'Replace spark plugs and inspect ignition coils.').
recommend(clogged_fuel_injector,      'Clean or replace fuel injectors; use injector cleaner additive.').
recommend(faulty_fuel_pump,           'Test fuel pump pressure; replace pump if pressure is low.').
recommend(worn_timing_belt,           'Inspect and replace the timing belt immediately - risk of engine damage.').
recommend(wheel_misalignment,         'Perform a wheel alignment and check tyre wear.').
recommend(worn_engine_mounts,         'Inspect and replace worn engine/transmission mounts.').
recommend(faulty_oxygen_sensor,       'Replace the oxygen (O2) sensor and clear the ECU fault code.').
recommend(clogged_air_filter,         'Replace the air filter.').
recommend(worn_brake_rotor,           'Inspect and machine/replace brake rotors and pads.').
recommend(low_engine_oil,             'Top up engine oil immediately and check for leaks.').
recommend(overheating_cooling_system, 'Check coolant level, radiator, water pump and thermostat urgently.').
recommend(worn_cv_joint,              'Inspect and replace the CV joint / drive-shaft boot.').
recommend(electrical_system_failure,  'Have the entire charging/electrical system tested by a technician.').

/* ============================================================
   STAGE 4b : FORWARD CHAINING ENGINE  (data-driven, non-recursive
   descent - iterates the rule set repeatedly over KNOWN facts
   until no new fault/1 can be derived: classic fixpoint forward
   chaining used in production-rule systems).
   ============================================================ */

fault_rule_list([
    weak_battery, faulty_starter_motor, faulty_alternator,
    worn_spark_plugs, clogged_fuel_injector, faulty_fuel_pump,
    worn_timing_belt, wheel_misalignment, worn_engine_mounts,
    faulty_oxygen_sensor, clogged_air_filter, worn_brake_rotor,
    low_engine_oil, overheating_cooling_system, worn_cv_joint,
    electrical_system_failure
]).

forward_chain :-
    retractall(fired(_)),
    forward_chain_step(_),
    !.

% Repeatedly scan every rule; assert any newly provable fault;
% stop when a full pass adds nothing new (fixpoint reached).
forward_chain_step(_) :-
    fault_rule_list(Faults),
    findall(F,
            ( member(F, Faults),
              \+ fault(F),             % not yet recorded as derived
              call(rule, F)            % but its production rule now fires
            ),
            NewFaults),
    ( NewFaults == []
    -> true                            % fixpoint reached, stop
    ;  ( forall(member(F, NewFaults),
                ( assertz(fault(F)),
                  assertz(fired(F)),
                  format("  [Forward-Chain] Rule fired -> fault(~w) derived~n", [F])
                )
              ),
         forward_chain_step(_)          % re-scan: new facts may enable more rules (e.g. R16)
    )
    ).

run_forward(Symptoms) :-
    format("~n===== FORWARD CHAINING RUN =====~n"),
    format("Asserting observed symptoms: ~w~n", [Symptoms]),
    retractall(symptom(_)), retractall(fault(_)),
    forall(member(S, Symptoms), assertz(symptom(S))),
    forward_chain,
    findall(F, fault(F), Faults),
    ( Faults == []
    -> format("No fault could be concluded from the given symptoms.~n")
    ;  ( format("~nConcluded faults:~n"),
         forall(member(F, Faults),
                ( recommend(F, Advice)
                -> format("  - ~w  =>  ~w~n", [F, Advice])
                ;  format("  - ~w~n", [F])
                ))
    )
    ).

/* ============================================================
   STAGE 4c : BACKWARD CHAINING ENGINE (goal-driven).
   Tries to prove a specific fault by working BACKWARDS from the
   goal through the rules to the symptoms. Any symptom whose
   truth is not yet known is treated as an ASKABLE leaf: the
   engine queries the user (or a supplied answer list, for
   automated / repeatable testing) and memoises the answer in
   known/2 so it is never asked twice.
   ============================================================ */

:- dynamic(answers/1).   % preset answers used during automated testing

% ask/1 : resolve the truth of a single symptom
ask(Symptom) :-
    known(Symptom, yes), !.
ask(Symptom) :-
    known(Symptom, no), !, fail.
ask(Symptom) :-
    answers(List), !,                       % automated / non-interactive mode
    ( member(Symptom-Answer, List)
    -> true
    ;  Answer = no
    ),
    assertz(known(Symptom, Answer)),
    format("  [Backward-Chain] Q: is '~w' present? (auto) -> ~w~n", [Symptom, Answer]),
    Answer == yes.
ask(Symptom) :-
    format("  [Backward-Chain] Is '~w' present? (yes/no): ", [Symptom]),
    read(Answer),
    assertz(known(Symptom, Answer)),
    Answer == yes.

% solve/1 : explicit backward-chaining meta-interpreter.
% Goal-driven: starts at fault(Goal) and expands it using the
% SAME production rules declared above, recursing into subgoals
% (which may themselves be faults, e.g. electrical_system_failure)
% and only consulting ask/1 for primitive symptom leaves.
solve(fault(F)) :-
    !,
    clause(rule(F), Body),
    solve(Body),
    ( fired(F) -> true ; assertz(fired(F)) ),
    ( fault(F) -> true ; assertz(fault(F)) ).   % memoise so R16-style chained goals reuse it
solve((A, B)) :-
    !,
    solve(A),
    solve(B).
solve(symptom(S)) :-
    !,
    ask(S).

run_backward(Fault, AnswerList) :-
    format("~n===== BACKWARD CHAINING RUN: goal = fault(~w) =====~n", [Fault]),
    retractall(known(_,_)), retractall(fired(_)), retractall(fault(_)), retractall(answers(_)),
    assertz(answers(AnswerList)),
    ( solve(fault(Fault))
    -> ( recommend(Fault, Advice)
       -> format("~nGOAL PROVED: fault(~w) confirmed.~nRecommendation: ~w~n", [Fault, Advice])
       ;  format("~nGOAL PROVED: fault(~w) confirmed.~n", [Fault])
       )
    ;  format("~nGOAL NOT PROVED: insufficient evidence for fault(~w).~n", [Fault])
    ).

/* ============================================================
   STAGE 7 : TEST HARNESS
   Demonstrates forward chaining on complete symptom sets and
   backward chaining proving/refuting specific hypotheses.
   ============================================================ */

test_forward_1 :-
    run_forward([dim_headlights, slow_engine_crank, no_crank]).

test_forward_2 :-
    run_forward([reduced_mileage, black_smoke, rough_idle,
                 check_engine_light, hard_start]).

test_forward_3 :-
    run_forward([battery_light, dim_headlights, stalls_after_start,
                 slow_engine_crank, no_crank]).

test_forward_4 :-
    run_forward([engine_hissing]).   % no rule concludes -> tests "no conclusion" path

test_backward_1 :-
    run_backward(worn_brake_rotor,
                 [braking_vibration-yes, engine_squealing-yes]).

test_backward_2 :-
    run_backward(faulty_starter_motor,
                 [clicking_sound_on_start-yes, no_crank-no]).  % expected to FAIL (refutation)

test_backward_3 :-
    run_backward(wheel_misalignment,
                 [steering_vibration-yes, high_speed_vibration-yes]).

test_backward_4 :-
    % Proves worn_timing_belt with all evidence present -> should SUCCEED
    run_backward(worn_timing_belt,
                 [engine_ticking-yes, check_engine_light-yes, stalls_after_start-yes]).

test_backward_5 :-
    % Proves the CHAINED meta-rule R16: backward chaining must recurse
    % through fault(weak_battery) and fault(faulty_alternator) subgoals
    run_backward(electrical_system_failure,
                 [dim_headlights-yes, slow_engine_crank-yes, no_crank-yes,
                  battery_light-yes, stalls_after_start-yes]).

run_all_tests :-
    test_forward_1, test_forward_2, test_forward_3, test_forward_4,
    test_backward_1, test_backward_2, test_backward_3,
    test_backward_4, test_backward_5,
    format("~n===== ALL TESTS COMPLETE =====~n").

/* ============================================================
   STAGE 6 : SIMPLE INTERACTIVE CONSULTATION (user interface)
   ============================================================ */

symptom_menu([
    dim_headlights, slow_engine_crank, no_crank, clicking_sound_on_start,
    battery_light, stalls_after_start, rough_idle, hard_start,
    check_engine_light, reduced_mileage, black_smoke, cranks_no_start,
    fuel_smell, engine_ticking, steering_vibration, high_speed_vibration,
    idle_vibration, engine_knocking, braking_vibration, engine_squealing,
    oil_light, low_oil_level, temp_light, engine_overheating,
    white_smoke, engine_grinding
]).

% consult_interactive/0 : asks about every symptom once, then runs
% forward chaining over the answers given (menu-driven demo mode).
consult_interactive :-
    format("~n--- Vehicle Fault Consultation (answer y/n) ---~n"),
    symptom_menu(Menu),
    findall(S,
            ( member(S, Menu),
              format("Is '~w' present? (y/n): ", [S]),
              read(Ans),
              ( Ans == y ; Ans == yes )
            ),
            Present),
    run_forward(Present).

/* Loading this file automatically runs the full automated test
   suite (repeatable, no keyboard input needed - ideal for
   grading/CI). For a LIVE menu-driven demonstration instead,
   comment out the two lines below and, after loading the file
   at the swipl prompt, call:   ?- consult_interactive.        */
:- initialization(main).
main :-
    run_all_tests,
    halt.
