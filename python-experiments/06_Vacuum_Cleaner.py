# Vacuum Cleaner Problem

rooms = {
    "A": "Dirty",
    "B": "Dirty"
}

location = "A"

print("Initial Room Status:")
print(rooms)
print()

while True:

    if rooms[location] == "Dirty":
        print("Vacuum cleans Room", location)
        rooms[location] = "Clean"

    if location == "A":
        location = "B"
    else:
        location = "A"

    if rooms["A"] == "Clean" and rooms["B"] == "Clean":
        break

print()
print("Final Room Status:")
print(rooms)
print("\nGoal Achieved!")