from sklearn.tree import DecisionTreeClassifier

# Training Data
X = [
    [25, 40000],
    [35, 60000],
    [45, 80000],
    [20, 20000],
    [30, 50000]
]

# Labels (0 = No, 1 = Yes)
y = [0, 1, 1, 0, 1]

# Create Decision Tree
model = DecisionTreeClassifier()

# Train the model
model.fit(X, y)

# Test Data
test = [[28, 45000]]

prediction = model.predict(test)

print("Prediction:", prediction[0])

if prediction[0] == 1:
    print("Result: Yes")
else:
    print("Result: No")