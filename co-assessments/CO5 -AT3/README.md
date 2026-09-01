# Automobile Fault Diagnosis Expert System

## Course
Artificial Intelligence and Expert Systems (MLA01)

## Problem
An automobile service center needs to identify possible vehicle faults from symptoms such as engine overheating, low coolant, starting failure, weak battery, abnormal noise, low oil, low mileage, high fuel consumption, and warning-light status.

## Objectives
- Model automobile diagnosis using production rules.
- Represent the same knowledge using propositional logic.
- Represent the domain using First-Order Logic.
- Implement the model in Prolog.
- Demonstrate forward and backward chaining.
- Compare the approaches and recommend a suitable model.

## Repository Structure

```text
production_rules/
propositional_logic/
first_order_logic/
prolog/
test_cases/
report/
```

## Prolog
Main implementation: `prolog/automobile_diagnosis.pl`

Example query:

```prolog
?- fault(car1, Fault).
```

Expected diagnoses for `car1` include `cooling_system_failure` and `engine_malfunction`.

## Forward and Backward Chaining
Forward chaining starts with known symptoms and derives conclusions. Backward chaining starts with a diagnosis goal and checks the supporting conditions.

## Recommended Model
For this simplified assignment, Prolog is recommended as the executable implementation because it supports facts, rules, variables, queries, and automated inference. First-Order Logic provides the strongest formal expressiveness among the compared representations.

## Student Details
- Name: __________________________
- Register No.: ___________________
- GitHub Repository: ______________
