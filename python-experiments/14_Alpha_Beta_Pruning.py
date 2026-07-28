# Alpha-Beta Pruning Algorithm

MAX = 1000
MIN = -1000

def alphabeta(depth, node_index, maximizing_player, values, alpha, beta, height):

    if depth == height:
        return values[node_index]

    if maximizing_player:
        best = MIN

        for i in range(2):
            val = alphabeta(depth + 1,
                            node_index * 2 + i,
                            False,
                            values,
                            alpha,
                            beta,
                            height)

            best = max(best, val)
            alpha = max(alpha, best)

            if beta <= alpha:
                break

        return best

    else:
        best = MAX

        for i in range(2):
            val = alphabeta(depth + 1,
                            node_index * 2 + i,
                            True,
                            values,
                            alpha,
                            beta,
                            height)

            best = min(best, val)
            beta = min(beta, best)

            if beta <= alpha:
                break

        return best

values = [3, 5, 6, 9, 1, 2, 0, -1]

height = 3

result = alphabeta(0, 0, True, values, MIN, MAX, height)

print("Optimal Value:", result)