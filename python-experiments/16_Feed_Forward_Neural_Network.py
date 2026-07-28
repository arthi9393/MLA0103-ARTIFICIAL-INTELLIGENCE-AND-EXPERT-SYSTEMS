from sklearn.neural_network import MLPClassifier

# Training Data
X = [
    [0, 0],
    [0, 1],
    [1, 0],
    [1, 1]
]

# Output (AND Gate)
y = [0, 0, 0, 1]

# Create Neural Network
model = MLPClassifier(
    hidden_layer_sizes=(2,),
    max_iter=5000,
    random_state=1
)

# Train the model
model.fit(X, y)

# Test Data
test = [[1, 1]]

prediction = model.predict(test)

print("Input:", test[0])
print("Prediction:", prediction[0])

if prediction[0] == 1:
    print("Output: True")
else:
    print("Output: False")