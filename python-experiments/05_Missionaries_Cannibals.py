from collections import deque

# Initial state: (Missionaries Left, Cannibals Left, Boat Side)
start = (3, 3, 1)

# Goal state
goal = (0, 0, 0)

moves = [
    (1, 0), (2, 0),
    (0, 1), (0, 2),
    (1, 1)
]

def is_valid(state):
    ml, cl, boat = state
    mr = 3 - ml
    cr = 3 - cl

    if ml < 0 or cl < 0 or mr < 0 or cr < 0:
        return False

    if ml > 0 and ml < cl:
        return False

    if mr > 0 and mr < cr:
        return False

    return True

def get_next_states(state):
    ml, cl, boat = state
    next_states = []

    for m, c in moves:
        if boat == 1:
            new_state = (ml - m, cl - c, 0)
        else:
            new_state = (ml + m, cl + c, 1)

        if is_valid(new_state):
            next_states.append(new_state)

    return next_states

def bfs():
    queue = deque([(start, [])])
    visited = set()

    while queue:
        state, path = queue.popleft()

        if state in visited:
            continue

        visited.add(state)

        if state == goal:
            return path + [state]

        for next_state in get_next_states(state):
            queue.append((next_state, path + [state]))

    return None

solution = bfs()

if solution:
    print("Solution Found:\n")
    for step in solution:
        print(step)
else:
    print("No Solution")