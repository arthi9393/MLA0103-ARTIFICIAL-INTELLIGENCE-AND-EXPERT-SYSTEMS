# Program 1: 8 Puzzle Problem

## Aim

To solve the 8-Puzzle Problem using Breadth First Search.

## Pseudocode

```text
BEGIN
Initialize initial state
Initialize goal state
Add initial state to queue
Repeat until queue is empty
    Remove first state
    If goal reached
        Display solution
        Stop
    Generate valid moves
    Add unvisited states to queue
END
```

## Output

```text
Solution Found
Initial State
Goal State
```

---

# Program 2: 8 Queen Problem

## Aim

To solve the 8-Queen Problem using Backtracking.

## Pseudocode

```text
BEGIN
Place queen in first column
Check if position is safe
If safe
    Place queen
    Move to next column
Else
    Try next row
Repeat until all queens are placed
Display solution
END
```

## Output

```text
Solution Found

[1,0,0,0,0,0,0,0]
...
```

---

# Program 3: Water Jug Problem

## Aim

To solve the Water Jug Problem using state space search.

## Pseudocode

```text
BEGIN
Initialize both jugs
Fill first jug
Transfer water
Empty second jug if full
Repeat until target amount is reached
Display steps
END
```

## Output

```text
Fill Jug1
Transfer Water
Empty Jug2
Goal Reached
```

---

# Program 4: Crypt Arithmetic Problem

## Aim

To solve the SEND + MORE = MONEY puzzle.

## Pseudocode

```text
BEGIN
Generate digit assignments
Check leading digit condition
Calculate SEND
Calculate MORE
Calculate MONEY
If equation is satisfied
Display solution
END
```

## Output

```text
SEND = 9567
MORE = 1085
MONEY = 10652
```

---

# Program 5: Missionaries and Cannibals Problem

## Aim

To solve the Missionaries and Cannibals Problem using Breadth First Search.

## Pseudocode

```text
BEGIN
Initialize starting state
Generate valid moves
Check safety conditions
Store unvisited states
Repeat until goal state is reached
Display solution path
END
```

## Output

```text
Solution Found

(3,3,1)
...
(0,0,0)
```

---

# Program 6: Vacuum Cleaner Problem

## Aim

To simulate the Vacuum Cleaner Agent.

## Pseudocode

```text
BEGIN
Check room status
If room is dirty
Clean room
Move to next room
Repeat until all rooms are clean
Display final status
END
```

## Output

```text
Initial Room Status

Vacuum cleans Room A
Vacuum cleans Room B

Final Room Status

Goal Achieved
```
---

# Program 7: Breadth First Search (BFS)

## Aim

To perform Breadth First Search traversal on a graph.

## Pseudocode

```text
BEGIN
Initialize queue
Mark starting node as visited
While queue is not empty
    Remove front node
    Display node
    Add all unvisited adjacent nodes to queue
END
```

## Output

```text
Breadth First Search Traversal:
A B C D E F G
```

---

# Program 8: Depth First Search (DFS)

## Aim

To perform Depth First Search traversal on a graph.

## Pseudocode

```text
BEGIN
Start from source node
Mark node as visited
Display node
Visit each unvisited adjacent node recursively
Repeat until all nodes are visited
END
```

## Output

```text
Depth First Search Traversal:
A B D E G C F
```

---

# Program 9: Travelling Salesman Problem (TSP)

## Aim

To find the shortest possible route that visits every city exactly once and returns to the starting city.

## Pseudocode

```text
BEGIN
Generate all possible routes
Calculate total cost for each route
Compare route costs
Select route with minimum cost
Display shortest path and minimum cost
END
```

## Output

```text
Shortest Path: A -> B -> D -> C -> A
Minimum Cost: 80
```

---

# Program 10: A* Search Algorithm

## Aim

To find the shortest path using the A* Search Algorithm.

## Pseudocode

```text
BEGIN
Initialize priority queue
Insert starting node
While queue is not empty
    Remove node with lowest cost
    If goal reached
        Display path
        Stop
    Expand neighboring nodes
    Update costs and priority
END
```

## Output

```text
Shortest Path: A -> C -> F -> G
Total Cost: 10
```

---

# Program 11: Map Coloring Problem

## Aim

To solve the Map Coloring Problem using Constraint Satisfaction.

## Pseudocode

```text
BEGIN
Assign a color to each state
Check neighboring states
If colors are different
    Continue
Else
    Try another color
Repeat until all states are colored
Display solution
END
```

## Output

```text
Map Coloring Solution:

A -> Red
B -> Green
C -> Blue
D -> Red
```
---

# Program 12: Tic Tac Toe

## Aim

To implement the Tic Tac Toe game using Python.

## Pseudocode

```text
BEGIN
Initialize an empty board
Set current player to X
Repeat until game ends
    Display board
    Read player move
    Place symbol on board
    Check winning condition
    If player wins
        Display winner
        Stop
    Switch player
If board is full
    Display draw
END
```

## Output

```text
Player X wins!
```

---

# Program 13: Minimax Algorithm

## Aim

To implement the Minimax Algorithm for decision making in game playing.

## Pseudocode

```text
BEGIN
If leaf node
    Return node value
If maximizing player
    Return maximum value of child nodes
Else
    Return minimum value of child nodes
Display optimal value
END
```

## Output

```text
Optimal Value: 12
```

---

# Program 14: Alpha-Beta Pruning

## Aim

To implement the Alpha-Beta Pruning Algorithm for efficient game tree search.

## Pseudocode

```text
BEGIN
Initialize alpha and beta
Traverse game tree
Update alpha and beta values
Prune branches when beta <= alpha
Return optimal value
Display result
END
```

## Output

```text
Optimal Value: 5
```

---

# Program 15: Decision Tree

## Aim

To classify data using the Decision Tree Algorithm.

## Pseudocode

```text
BEGIN
Load training data
Train Decision Tree model
Provide test data
Predict output
Display prediction
END
```

## Output

```text
Prediction: 0
Result: No
```

---

# Program 16: Feed Forward Neural Network

## Aim

To implement a Feed Forward Neural Network using Python.

## Pseudocode

```text
BEGIN
Load training data
Create neural network model
Train the model
Provide test input
Predict output
Display result
END
```

## Output

```text
Input: [1, 1]
Prediction: 1
Output: True
```

---

# Conclusion

The Python AI laboratory experiments were successfully implemented and executed. The programs demonstrate fundamental Artificial Intelligence concepts including search algorithms, problem solving, game playing, constraint satisfaction, machine learning, and neural networks. These experiments provide practical knowledge of AI techniques using Python.

