# Map Coloring using Backtracking

states = ['A', 'B', 'C', 'D']

neighbors = {
    'A': ['B', 'C'],
    'B': ['A', 'C', 'D'],
    'C': ['A', 'B', 'D'],
    'D': ['B', 'C']
}

colors = ['Red', 'Green', 'Blue']

result = {}

def is_safe(state, color):
    for neighbor in neighbors[state]:
        if neighbor in result and result[neighbor] == color:
            return False
    return True

def solve(index):
    if index == len(states):
        return True

    state = states[index]

    for color in colors:
        if is_safe(state, color):
            result[state] = color

            if solve(index + 1):
                return True

            del result[state]

    return False

if solve(0):
    print("Map Coloring Solution:\n")
    for state in states:
        print(state, "->", result[state])
else:
    print("No Solution Exists")