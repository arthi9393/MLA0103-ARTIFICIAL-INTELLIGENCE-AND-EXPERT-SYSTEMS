# Minimax Algorithm

def minimax(depth, node_index, is_max, values, height):

    if depth == height:
        return values[node_index]

    if is_max:
        return max(
            minimax(depth + 1, node_index * 2, False, values, height),
            minimax(depth + 1, node_index * 2 + 1, False, values, height)
        )
    else:
        return min(
            minimax(depth + 1, node_index * 2, True, values, height),
            minimax(depth + 1, node_index * 2 + 1, True, values, height)
        )

values = [3, 5, 2, 9, 12, 5, 23, 23]

height = 3

result = minimax(0, 0, True, values, height)

print("Optimal Value:", result)