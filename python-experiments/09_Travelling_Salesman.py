from itertools import permutations

graph = {
    'A': {'B': 10, 'C': 15, 'D': 20},
    'B': {'A': 10, 'C': 35, 'D': 25},
    'C': {'A': 15, 'B': 35, 'D': 30},
    'D': {'A': 20, 'B': 25, 'C': 30}
}

cities = list(graph.keys())

min_cost = float('inf')
best_path = None

for path in permutations(cities[1:]):
    tour = ['A'] + list(path) + ['A']

    cost = 0
    for i in range(len(tour) - 1):
        cost += graph[tour[i]][tour[i + 1]]

    if cost < min_cost:
        min_cost = cost
        best_path = tour

print("Shortest Path:", " -> ".join(best_path))
print("Minimum Cost:", min_cost)