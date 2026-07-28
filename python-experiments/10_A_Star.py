import heapq

# Graph with edge costs
graph = {
    'A': [('B', 1), ('C', 3)],
    'B': [('D', 3), ('E', 6)],
    'C': [('F', 5)],
    'D': [],
    'E': [('G', 2)],
    'F': [('G', 2)],
    'G': []
}

# Heuristic values
heuristic = {
    'A': 7,
    'B': 6,
    'C': 4,
    'D': 3,
    'E': 2,
    'F': 1,
    'G': 0
}

def astar(start, goal):
    pq = []
    heapq.heappush(pq, (heuristic[start], 0, start, [start]))
    visited = set()

    while pq:
        f, cost, node, path = heapq.heappop(pq)

        if node in visited:
            continue

        visited.add(node)

        if node == goal:
            return path, cost

        for neighbor, weight in graph[node]:
            if neighbor not in visited:
                new_cost = cost + weight
                new_f = new_cost + heuristic[neighbor]
                heapq.heappush(pq, (new_f, new_cost, neighbor, path + [neighbor]))

    return None, None

path, cost = astar('A', 'G')

print("Shortest Path:", " -> ".join(path))
print("Total Cost:", cost)