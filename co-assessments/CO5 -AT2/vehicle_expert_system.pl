%% =====================================================================
%%  VEHICLE FAULT DIAGNOSIS EXPERT SYSTEM
%%  Automobile Industry - Service Centre Diagnostic Support
%%  Implemented in SWI-Prolog
%%
%%  Demonstrates:
%%    - Knowledge representation using facts and production rules
%%    - Forward chaining  (data-driven, working-memory based)
%%    - Backward chaining (goal-driven, recursive proof with explanation)
%%    - Unification and backtracking (via findall over rule/3)
%% =====================================================================

:- dynamic(fault_derived/2).
:- dynamic(symptom/2).
:- dynamic(observation/2).
:- discontiguous(symptom/2).
:- discontiguous(observation/2).

%% ---------------------------------------------------------------------
%% 1. KNOWLEDGE BASE : CASE FACTS (symptoms reported by customer,
%%    observations recorded by the technician during inspection)
%% ---------------------------------------------------------------------

% --- Case 1: Engine overheating with visible coolant leak ---
symptom(case1, engine_overheating).
observation(case1, coolant_level_low).
observation(case1, radiator_leak_visible).

% --- Case 2: Difficulty starting, weak battery signature ---
symptom(case2, difficulty_starting).
observation(case2, battery_voltage_low).
observation(case2, slow_cranking).

% --- Case 3: Abnormal noise, engine knocking ---
symptom(case3, abnormal_noise).
observation(case3, knocking_sound).

% --- Case 4: Low mileage / poor fuel economy, injector problem ---
symptom(case4, low_mileage).
observation(case4, injector_clicking_irregular).
observation(case4, black_exhaust_smoke).

% --- Case 5: Compound / multi-fault case -> triggers chained rule ---
symptom(case5, engine_overheating).
observation(case5, coolant_level_low).
observation(case5, radiator_leak_visible).
symptom(case5, warning_light_activation).
observation(case5, oil_pressure_light_on).

% --- Case 6: Overheating WITHOUT a leak -> different diagnosis (thermostat) ---
symptom(case6, engine_overheating).
observation(case6, thermostat_stuck).
observation(case6, fan_not_working).

%% ---------------------------------------------------------------------
%% 2. PRODUCTION RULES : rule(RuleId, Conclusion, [Conditions...])
%%    Conditions may reference symptoms, observations, OR other faults
%%    (this allows multi-level / chained inference).
%% ---------------------------------------------------------------------

rule(r1, cooling_system_failure,
     [engine_overheating, coolant_level_low, radiator_leak_visible]).

rule(r2, thermostat_fault,
     [engine_overheating, thermostat_stuck]).

rule(r3, radiator_fan_fault,
     [engine_overheating, fan_not_working]).

rule(r4, weak_battery,
     [difficulty_starting, battery_voltage_low, slow_cranking]).

rule(r5, starter_motor_fault,
     [difficulty_starting, clicking_sound_on_start, starter_motor_noise]).

rule(r6, fuel_delivery_fault,
     [difficulty_starting, fuel_smell_no_start]).

rule(r7, drive_belt_fault,
     [abnormal_noise, squealing_belt]).

rule(r8, engine_knock_fault,
     [abnormal_noise, knocking_sound]).

rule(r9, brake_pad_worn,
     [abnormal_noise, grinding_brake_noise]).

rule(r10, exhaust_leak,
     [abnormal_noise, exhaust_hissing]).

rule(r11, suspension_fault,
     [abnormal_noise, clunking_suspension]).

rule(r12, air_filter_clogged,
     [low_mileage, dirty_air_filter, rough_idle]).

rule(r13, fuel_injector_fault,
     [low_mileage, injector_clicking_irregular, black_exhaust_smoke]).

rule(r14, tire_pressure_fault,
     [low_mileage, low_tire_pressure]).

rule(r15, engine_management_fault,
     [warning_light_activation, check_engine_on]).

rule(r16, oil_pressure_fault,
     [warning_light_activation, oil_pressure_light_on]).

rule(r17, charging_system_fault,
     [warning_light_activation, battery_light_on]).

rule(r18, brake_system_warning,
     [warning_light_activation, brake_light_on]).

rule(r19, coolant_system_warning,
     [warning_light_activation, coolant_light_on]).

% --- Chained / compound rule: fires only after two OTHER faults
%     have already been established -> demonstrates multi-level inference
rule(r20, severe_engine_risk,
     [cooling_system_failure, oil_pressure_fault]).

%% ---------------------------------------------------------------------
%% 3. RECOMMENDED ACTIONS (output / explanation module)
%% ---------------------------------------------------------------------

action(cooling_system_failure,
  'Pressure-test cooling system, repair/replace radiator or hose, refill coolant, re-test for leaks.').
action(thermostat_fault,
  'Replace faulty thermostat and refill coolant to correct level.').
action(radiator_fan_fault,
  'Inspect fan motor/relay/fuse; replace radiator fan assembly if non-functional.').
action(weak_battery,
  'Test battery health, charge or replace battery, inspect alternator charging output.').
action(starter_motor_fault,
  'Inspect and replace starter motor / solenoid; check wiring connections.').
action(fuel_delivery_fault,
  'Check fuel pump pressure and injectors; inspect for flooding or fuel line blockage.').
action(drive_belt_fault,
  'Inspect and replace worn/loose drive (serpentine) belt; check tensioner.').
action(engine_knock_fault,
  'Inspect engine bearings, ignition timing and fuel octane rating; schedule detailed engine diagnostics.').
action(brake_pad_worn,
  'Inspect brake pads and rotors; replace worn brake pads immediately.').
action(exhaust_leak,
  'Inspect exhaust manifold and gaskets for leaks; repair or replace damaged section.').
action(suspension_fault,
  'Inspect suspension bushings, struts and joints; replace worn components.').
action(air_filter_clogged,
  'Replace air filter and clean throttle body to restore fuel efficiency.').
action(fuel_injector_fault,
  'Clean or replace faulty fuel injector(s); perform injector balance test.').
action(tire_pressure_fault,
  'Inflate tires to recommended pressure; check for slow punctures.').
action(engine_management_fault,
  'Scan ECU fault codes with OBD-II scanner and diagnose the specific reported code.').
action(oil_pressure_fault,
  'Check engine oil level immediately; inspect oil pump and pressure sensor; avoid driving until resolved.').
action(charging_system_fault,
  'Inspect alternator, drive belt and battery terminals; test charging voltage.').
action(brake_system_warning,
  'Inspect brake fluid level, brake pads and ABS sensors urgently.').
action(coolant_system_warning,
  'Check coolant level and cooling system for leaks before continuing to drive.').
action(severe_engine_risk,
  'CRITICAL: Stop the vehicle and do not operate. Combined overheating and low oil pressure risk severe engine damage - immediate workshop inspection required.').

%% =====================================================================
%% 4. FORWARD CHAINING  (data-driven, working-memory / assert-based)
%%    Starts from known symptoms/observations and fires rules whenever
%%    ALL their conditions are already known, iterating to a fixpoint.
%% =====================================================================

forward_chain(Case) :-
    retractall(fault_derived(Case, _)),
    format("~n=== FORWARD CHAINING TRACE for ~w ===~n", [Case]),
    fc_loop(Case),
    format("--- Forward chaining complete for ~w ---~n", [Case]).

fc_loop(Case) :-
    ( fc_step(Case) -> fc_loop(Case)
    ; format("No further rules fire. Fixpoint reached.~n")
    ).

fc_step(Case) :-
    rule(RuleId, Fault, Conditions),
    \+ fault_derived(Case, Fault),
    fc_all_known(Case, Conditions),
    assertz(fault_derived(Case, Fault)),
    format("[Rule ~w] all conditions ~w satisfied -> DERIVED: ~w~n",
           [RuleId, Conditions, Fault]),
    !.

fc_all_known(_, []).
fc_all_known(Case, [C|Rest]) :-
    fc_known(Case, C),
    fc_all_known(Case, Rest).

fc_known(Case, X) :- symptom(Case, X), !.
fc_known(Case, X) :- observation(Case, X), !.
fc_known(Case, X) :- fault_derived(Case, X), !.

%% =====================================================================
%% 5. BACKWARD CHAINING  (goal-driven, recursive proof + explanation)
%%    Starts from a goal fault and recursively proves each condition,
%%    printing an explanation trace. Conditions that are themselves
%%    fault names trigger further backward chaining (multi-level).
%% =====================================================================

conclude(Case, Fault) :-
    rule(RuleId, Fault, Conditions),
    format("[BC] Trying rule ~w to prove goal '~w' for ~w~n", [RuleId, Fault, Case]),
    check_all(Case, Conditions, RuleId).

check_all(_, [], _).
check_all(Case, [Cond|Rest], RuleId) :-
    check_one(Case, Cond, RuleId),
    check_all(Case, Rest, RuleId).

check_one(Case, Cond, RuleId) :-
    ( symptom(Case, Cond) ->
        format("   [~w] condition '~w' satisfied: matches known SYMPTOM~n", [RuleId, Cond])
    ; observation(Case, Cond) ->
        format("   [~w] condition '~w' satisfied: matches known OBSERVATION~n", [RuleId, Cond])
    ; conclude(Case, Cond) ->
        format("   [~w] condition '~w' satisfied: proven via CHAINED SUB-GOAL~n", [RuleId, Cond])
    ; ( format("   [~w] condition '~w' FAILED - no matching fact or sub-goal~n", [RuleId, Cond]), fail )
    ).

%% Explanation wrapper used at top-level queries
diagnose(Case, Fault, Action) :-
    conclude(Case, Fault),
    action(Fault, Action),
    format("~n>>> CONCLUSION: ~w is diagnosed with '~w'~n", [Case, Fault]),
    format(">>> RECOMMENDED ACTION: ~w~n~n", [Action]).

%% =====================================================================
%% 6. UNIFICATION & BACKTRACKING DEMONSTRATION
%%    Enumerates every fault that CAN be proven for a case by
%%    backtracking over all rule/3 clauses (Fault left unbound so it
%%    unifies with each rule head in turn).
%% =====================================================================

all_faults(Case, Faults) :-
    findall(Fault, (rule(_, Fault, _), conclude(Case, Fault)), Unsorted),
    sort(Unsorted, Faults).

full_report(Case) :-
    format("~n############################################################~n"),
    format("  FULL DIAGNOSTIC REPORT: ~w~n", [Case]),
    format("############################################################~n"),
    format("Known symptoms:~n"),
    forall(symptom(Case, S), format("  - ~w~n", [S])),
    format("Known observations:~n"),
    forall(observation(Case, O), format("  - ~w~n", [O])),
    forward_chain(Case),
    format("~nBackward-chaining verification & unification/backtracking sweep:~n"),
    all_faults(Case, Faults),
    format("~nAll faults provable for ~w (via backtracking over rules): ~w~n", [Case, Faults]),
    format("~nRecommended actions:~n"),
    forall(member(F, Faults),
           ( action(F, A) -> format("  * ~w -> ~w~n", [F, A]) ; true )),
    format("############################################################~n~n").
