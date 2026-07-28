# Water Jug Problem

def water_jug(capacity1, capacity2, target):
    print("Steps:")

    jug1 = 0
    jug2 = 0

    while jug2 != target:

        if jug1 == 0:
            jug1 = capacity1
            print("Fill Jug1:", (jug1, jug2))

        transfer = min(jug1, capacity2 - jug2)
        jug1 -= transfer
        jug2 += transfer
        print("Transfer Jug1 -> Jug2:", (jug1, jug2))

        if jug2 == target:
            break

        if jug2 == capacity2:
            jug2 = 0
            print("Empty Jug2:", (jug1, jug2))

water_jug(4, 3, 2)