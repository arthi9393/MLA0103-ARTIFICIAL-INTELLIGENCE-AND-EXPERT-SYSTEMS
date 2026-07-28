from collections import deque

# Goal state
goal = (1, 2, 3,
        4, 5, 6,
        7, 8, 0)

# Initial state
start = (1, 2, 3,
         4, 5, 6,
         7, 0, 8)

# Function to print puzzle
def print_state(state):
    for i in range(0, 9, 3):
        print(state[i:i+3])
    print()

# Generate possible moves
def get_neighbors(state):
    neighbors = []
    zero = state.index(0)

    row = zero // 3
    col = zero % 3

    moves = [(-1,0),(1,0),(0,-1),(0,1)]

    for dr, dc in moves:
        r = row + dr
        c = col + dc

        if 0 <= r < 3 and 0 <= c < 3:
            new_state = list(state)
            new_pos = r * 3 + c

            new_state[zero], new_state[new_pos] = new_state[new_pos], new_state[zero]

            neighbors.append(tuple(new_state))

    return neighbors

# Breadth First Search
def bfs(start, goal):
    queue = deque([(start, [])])
    visited = set()

    while queue:
        state, path = queue.popleft()

        if state in visited:
            continue

        visited.add(state)

        if state == goal:
            return path + [state]

        for neighbor in get_neighbors(state):
            queue.append((neighbor, path + [state]))

    return None

# Main Program
solution = bfs(start, goal)

if solution:
    print("Solution Found!\n")
    for step in solution:
        print_state(step)
else:
    print("No Solution Exists.")