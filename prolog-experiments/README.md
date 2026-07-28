# Prolog Experiments

# Program 1: Sum of Integers from 1 to n

## Aim
To find the sum of first N natural numbers using recursion.

## Algorithm

1. Start.
2. Read the value of N.
3. If N = 0, return 0.
4. Otherwise compute Sum(N−1).
5. Add N to the previous sum.
6. Display the result.
7. Stop.

## Query

?- sum(5,S).

## Output

S = 15.

---

# Program 2: Name and Date of Birth Database

## Aim
To create a database storing names and dates of birth.

## Algorithm

1. Start.
2. Store person names and DOB as facts.
3. Accept a person's name.
4. Search the database.
5. Display the DOB.
6. Stop.

## Query

?- person(arun,DOB).

## Output

DOB = '10-05-2003'.

---

# Program 3: Student, Teacher and Subject Database

## Aim
To create a simple educational database.

## Algorithm

1. Start.
2. Store students.
3. Store teachers.
4. Store subjects.
5. Store teaching relationships.
6. Store studying relationships.
7. Execute query.
8. Display result.
9. Stop.

## Query

?- teaches(ramesh,maths).

## Output

true.

---

# Program 4: Database of Planets

## Aim
To create a database containing planets and their distance.

## Algorithm

1. Start.
2. Store planet names.
3. Store distances.
4. Execute query.
5. Display output.
6. Stop.

## Query

?- distance(earth,D).

## Output

D = 150.

---

# Program 5: Towers of Hanoi

## Aim
To solve the Towers of Hanoi problem recursively.

## Algorithm

1. Start.
2. If only one disk exists, move it.
3. Move N−1 disks to auxiliary rod.
4. Move largest disk.
5. Move remaining disks.
6. Stop.

## Query

?- hanoi(3,left,right,center).

## Output

Move disk 1...
Move disk 2...
Move disk 3...

---

# Program 6: Bird Can Fly or Not

## Aim
To determine whether a bird can fly.

## Algorithm

1. Start.
2. Store bird names.
3. Store birds that cannot fly.
4. Check whether bird is in cannot_fly list.
5. Display result.
6. Stop.

## Query

?- can_fly(parrot).

## Output

true.

## Query

?- can_fly(penguin).

## Output

false.

---

# Program 7: Family Tree

## Aim
To represent family relationships.

## Algorithm

1. Start.
2. Store parent facts.
3. Store male and female facts.
4. Define father rule.
5. Define mother rule.
6. Define grandparent rule.
7. Execute query.
8. Display result.
9. Stop.

## Query

?- father(john,david).

## Output

true.

---

# Program 8: Dieting System

## Aim
To recommend diet based on health condition.

## Algorithm

1. Start.
2. Store health conditions.
3. Store diet recommendation.
4. Execute query.
5. Display recommended diet.
6. Stop.

## Query

?- diet(bp,X).

## Output

X = low_salt.
---

# Program 9: Monkey Banana Problem

## Aim
To determine whether the monkey can get the banana.

## Algorithm

1. Start.
2. Store the objects possessed by the monkey.
3. Check if the monkey has both the box and the banana.
4. If yes, display that the monkey can get the banana.
5. Otherwise, display failure.
6. Stop.

## Query

?- can_get_banana.

## Output

true.

---

# Program 10: Fruit and Color Database

## Aim
To create a database of fruits and their colors.

## Algorithm

1. Start.
2. Store fruit names and their colors.
3. Accept a fruit name.
4. Search the database.
5. Display the corresponding color.
6. Stop.

## Query

?- fruit(apple,Color).

## Output

Color = red.

---

# Program 11: Best First Search

## Aim
To implement Best First Search using graph traversal.

## Algorithm

1. Start.
2. Store graph edges.
3. Select the starting node.
4. Visit connected nodes.
5. Continue until the goal node is reached.
6. Display the path.
7. Stop.

## Query

?- best_first(a,g).

## Output

true.

---

# Program 12: Medical Diagnosis Expert System

## Aim
To identify diseases based on symptoms.

## Algorithm

1. Start.
2. Store symptoms and diseases.
3. Accept a symptom.
4. Search the knowledge base.
5. Display the disease.
6. Stop.

## Query

?- disease(fever,X).

## Output

X = flu.

---

# Program 13: Forward Chaining

## Aim
To demonstrate Forward Chaining in Prolog.

## Algorithm

1. Start.
2. Store known facts.
3. Apply inference rules.
4. Derive new facts.
5. Display the inferred result.
6. Stop.

## Query

?- disease(john,flu).

## Output

true.

---

# Program 14: Backward Chaining

## Aim
To demonstrate Backward Chaining.

## Algorithm

1. Start.
2. Accept a goal.
3. Search for matching rules.
4. Verify required facts.
5. If all facts are true, prove the goal.
6. Stop.

## Query

?- flu(raja).

## Output

true.

---

# Program 15: Marcus Program

## Aim
To demonstrate logical reasoning using facts and rules.

## Algorithm

1. Start.
2. Store facts about Marcus and Caesar.
3. Define Roman, loyal and hate rules.
4. Execute the required query.
5. Display the logical result.
6. Stop.

## Query

?- loyal(marcus,caesar).

## Output

true.

## Query

?- hates(marcus,caesar).

## Output

false.

---

# Program 16: John Likes Peanuts

## Aim
To represent a simple fact in Prolog.

## Algorithm

1. Start.
2. Store the fact that John likes peanuts.
3. Execute the query.
4. Display the result.
5. Stop.

## Query

?- likes(john,peanuts).

## Output

true.
---

# Program 17: John Likes All Kinds of Food

## Aim
To demonstrate the use of rules in Prolog.

## Algorithm

1. Start.
2. Store different food items.
3. Define the rule that John likes all food.
4. Execute the query.
5. Display the result.
6. Stop.

## Query

?- likes(john,pizza).

## Output

true.

---

# Program 18: Harry Eats Everything That Anil Eats

## Aim
To demonstrate inheritance of facts using rules.

## Algorithm

1. Start.
2. Store the food eaten by Anil.
3. Define the rule that Harry eats everything Anil eats.
4. Execute the query.
5. Display the result.
6. Stop.

## Query

?- eats(harry,peanuts).

## Output

true.

---

# Program 19: Anil Eats Peanuts and Is Still Alive

## Aim
To represent simple facts using Prolog.

## Algorithm

1. Start.
2. Store the fact that Anil eats peanuts.
3. Store the fact that Anil is alive.
4. Execute the queries.
5. Display the results.
6. Stop.

## Query

?- eats(anil,peanuts).

## Output

true.

## Query

?- alive(anil).

## Output

true.

---

# Program 20: Anything Anyone Eats and Is Not Killed Is Food

## Aim
To identify food using logical rules.

## Algorithm

1. Start.
2. Store facts about what different people eat.
3. Store information about who is killed.
4. Define a rule to identify food.
5. Execute the query.
6. Display the result.
7. Stop.

## Query

?- food(apple).

## Output

true.

---

# Program 21: Apples and Vegetables Are Food

## Aim
To represent food facts and determine John's preferences.

## Algorithm

1. Start.
2. Store apple and vegetable as food.
3. Define the rule that John likes every food item.
4. Execute the query.
5. Display the result.
6. Stop.

## Query

?- likes(john,apple).

## Output

true.

## Query

?- likes(john,vegetable).

## Output

true.

---

# Conclusion

These Prolog programs demonstrate the use of facts, rules, recursion, databases, expert systems, forward chaining, backward chaining, graph search, and logical reasoning. The experiments were successfully implemented and executed using SWI-Prolog.

