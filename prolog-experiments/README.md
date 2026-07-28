# Prolog Experiments

# Program 1: Sum of Integers from 1 to n

## Aim

To find the sum of the first N natural numbers using recursion.

## Pseudocode

```text
BEGIN
INPUT N
IF N = 0 THEN
    RETURN 0
ELSE
    SUM = SUM(N-1) + N
END IF
DISPLAY SUM
END
```

## Query

```prolog
?- sum(5,S).
```

## Output

```text
S = 15.
```

---

# Program 2: Name and Date of Birth Database

## Aim

To create a database of persons and their dates of birth.

## Pseudocode

```text
BEGIN
STORE person's name and date of birth
INPUT person's name
SEARCH the database
DISPLAY date of birth
END
```

## Query

```prolog
?- person(arun,DOB).
```

## Output

```text
DOB = '10-05-2003'.
```

---

# Program 3: Create a Database of Students, Teachers and Subjects

## Aim

To create a database containing students, teachers and subjects.

## Pseudocode

```text
BEGIN
STORE student details
STORE teacher details
STORE subject details
STORE teaching relationship
STORE studying relationship
INPUT query
DISPLAY result
END
```

## Query

```prolog
?- teaches(ramesh,maths).
```

## Output

```text
true.
```

### Query

```prolog
?- studies(arun,maths).
```

### Output

```text
true.
```

---

# Program 4: Database of Planets

## Aim

To create a database of planets and their distances.

## Pseudocode

```text
BEGIN
STORE planet names
STORE planet distances
INPUT planet name
SEARCH database
DISPLAY distance
END
```

## Query

```prolog
?- distance(earth,D).
```

## Output

```text
D = 150.
```

---

# Program 5: Towers of Hanoi

## Aim

To solve the Towers of Hanoi problem using recursion.

## Pseudocode

```text
BEGIN
IF number of disks = 1 THEN
    MOVE disk to destination
ELSE
    MOVE N-1 disks to auxiliary rod
    MOVE largest disk
    MOVE N-1 disks to destination
END IF
END
```

## Query

```prolog
?- hanoi(3,left,right,center).
```

## Output

```text
Move disk 1 from left to right
Move disk 2 from left to center
Move disk 1 from right to center
Move disk 3 from left to right
Move disk 1 from center to left
Move disk 2 from center to right
Move disk 1 from left to right
```

---

# Program 6: Bird Can Fly or Not

## Aim

To determine whether a bird can fly.

## Pseudocode

```text
BEGIN
STORE bird names
STORE birds that cannot fly
INPUT bird name
IF bird can fly THEN
    DISPLAY true
ELSE
    DISPLAY false
END IF
END
```

## Query

```prolog
?- can_fly(parrot).
```

## Output

```text
true.
```

### Query

```prolog
?- can_fly(penguin).
```

## Output

```text
false.
```

---

# Program 7: Family Tree

## Aim

To represent family relationships using Prolog facts and rules.

## Pseudocode

```text
BEGIN
STORE parent relationships
STORE male and female facts
DEFINE father rule
DEFINE mother rule
DEFINE grandparent rule
EXECUTE query
DISPLAY result
END
```

## Query

```prolog
?- father(john,david).
```

## Output

```text
true.
```

### Query

```prolog
?- mother(mary,david).
```

## Output

```text
true.
```

### Query

```prolog
?- grandparent(john,peter).
```

## Output

```text
true.
```

---

# Program 8: Dieting System

## Aim

To recommend a suitable diet based on health conditions.

## Pseudocode

```text
BEGIN
STORE disease and diet details
INPUT disease
SEARCH database
DISPLAY recommended diet
END
```

## Query

```prolog
?- diet(bp,X).
```

## Output

```text
X = low_salt.
```

# Program 9: Monkey Banana Problem

## Aim

To determine whether the monkey can obtain the banana.

## Pseudocode

```text
BEGIN
STORE monkey facts
CHECK whether monkey has box
CHECK whether monkey has banana
IF both are available THEN
    DISPLAY monkey can get banana
ELSE
    DISPLAY monkey cannot get banana
END IF
END
```

## Query

```prolog
?- can_get_banana.
```

## Output

```text
true.
```

---

# Program 10: Fruit and Color Database

## Aim

To create a database of fruits and their colors.

## Pseudocode

```text
BEGIN
STORE fruit names
STORE corresponding colors
INPUT fruit name
SEARCH database
DISPLAY fruit color
END
```

## Query

```prolog
?- fruit(apple,Color).
```

## Output

```text
Color = red.
```

### Query

```prolog
?- fruit(mango,Color).
```

### Output

```text
Color = yellow.
```

---

# Program 11: Best First Search

## Aim

To perform graph traversal using Best First Search.

## Pseudocode

```text
BEGIN
STORE graph edges
SELECT starting node
VISIT adjacent node
IF destination reached THEN
    DISPLAY success
ELSE
    CONTINUE traversal
END IF
END
```

## Query

```prolog
?- best_first(a,g).
```

## Output

```text
true.
```

---

# Program 12: Medical Diagnosis Expert System

## Aim

To identify diseases based on symptoms.

## Pseudocode

```text
BEGIN
STORE symptoms
STORE diseases
INPUT symptom
SEARCH knowledge base
DISPLAY disease
END
```

## Query

```prolog
?- disease(fever,X).
```

## Output

```text
X = flu.
```

---

# Program 13: Forward Chaining

## Aim

To infer conclusions using forward chaining.

## Pseudocode

```text
BEGIN
STORE known facts
APPLY inference rules
GENERATE new facts
DISPLAY inferred conclusion
END
```

## Query

```prolog
?- disease(john,flu).
```

## Output

```text
true.
```

---

# Program 14: Backward Chaining

## Aim

To infer conclusions using backward chaining.

## Pseudocode

```text
BEGIN
INPUT goal
SEARCH matching rule
VERIFY supporting facts
IF facts are true THEN
    DISPLAY goal proved
ELSE
    DISPLAY goal failed
END IF
END
```

## Query

```prolog
?- flu(raja).
```

## Output

```text
true.
```

---

# Program 15: Marcus Program

## Aim

To demonstrate logical reasoning using facts and rules.

## Pseudocode

```text
BEGIN
STORE facts about Marcus
STORE facts about Caesar
DEFINE Roman rule
DEFINE Loyal rule
DEFINE Hate rule
EXECUTE query
DISPLAY result
END
```

## Query

```prolog
?- loyal(marcus,caesar).
```

## Output

```text
true.
```

### Query

```prolog
?- hates(marcus,caesar).
```

### Output

```text
false.
```

---

# Program 16: John Likes Peanuts

## Aim

To represent a simple fact in Prolog.

## Pseudocode

```text
BEGIN
STORE the fact that John likes peanuts
EXECUTE query
DISPLAY result
END
```

## Query

```prolog
?- likes(john,peanuts).
```

## Output

```text
true.
```

# Program 17: John Likes All Kinds of Food

## Aim

To demonstrate the use of rules in Prolog.

## Pseudocode

```text
BEGIN
STORE food items
DEFINE rule that John likes every food item
INPUT food item
IF item is food THEN
    DISPLAY true
ELSE
    DISPLAY false
END IF
END
```

## Query

```prolog
?- likes(john,pizza).
```

## Output

```text
true.
```

### Query

```prolog
?- likes(john,mango).
```

### Output

```text
true.
```

---

# Program 18: Harry Eats Everything That Anil Eats

## Aim

To demonstrate inheritance of facts using rules.

## Pseudocode

```text
BEGIN
STORE foods eaten by Anil
DEFINE rule that Harry eats everything Anil eats
INPUT food item
CHECK whether Anil eats the food
DISPLAY result
END
```

## Query

```prolog
?- eats(harry,peanuts).
```

## Output

```text
true.
```

---

# Program 19: Anil Eats Peanuts and Is Still Alive

## Aim

To represent simple facts using Prolog.

## Pseudocode

```text
BEGIN
STORE fact that Anil eats peanuts
STORE fact that Anil is alive
EXECUTE query
DISPLAY result
END
```

## Query

```prolog
?- eats(anil,peanuts).
```

## Output

```text
true.
```

### Query

```prolog
?- alive(anil).
```

### Output

```text
true.
```

---

# Program 20: Anything Anyone Eats and Is Not Killed Is Food

## Aim

To identify food using logical rules.

## Pseudocode

```text
BEGIN
STORE eating facts
STORE killed facts
DEFINE rule:
IF a person eats something
AND the person is not killed
THEN it is food
EXECUTE query
DISPLAY result
END
```

## Query

```prolog
?- food(apple).
```

## Output

```text
true.
```

### Query

```prolog
?- food(rice).
```

## Output

```text
true.
```

---

# Program 21: Apples and Vegetables Are Food

## Aim

To identify food items and determine John's preferences.

## Pseudocode

```text
BEGIN
STORE apple as food
STORE vegetable as food
DEFINE rule that John likes every food item
EXECUTE query
DISPLAY result
END
```

## Query

```prolog
?- likes(john,apple).
```

## Output

```text
true.
```

### Query

```prolog
?- likes(john,vegetable).
```

## Output

```text
true.
```

---

# Conclusion

The Prolog experiments were successfully implemented using SWI-Prolog. These programs demonstrate the use of facts, rules, recursion, databases, family relationships, graph search, expert systems, forward chaining, backward chaining, and logical reasoning. The outputs obtained verify the correctness of the implemented Prolog programs.

