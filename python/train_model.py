
import json
from pathlib import Path

import numpy as np
from sklearn.datasets import make_classification
from sklearn.linear_model import LogisticRegression
from sklearn.model_selection import train_test_split
from sklearn.metrics import accuracy_score


# 1. Generate a reproducible dataset
X, y = make_classification(
    n_samples=300,
    n_features=2,
    n_informative=2,
    n_redundant=0,
    n_clusters_per_class=1,
    class_sep=1.5,
    random_state=42,
)


# 2. Split into training and test sets
X_train, X_test, y_train, y_test = train_test_split(
    X,
    y,
    test_size=0.2,
    random_state=42,
    stratify=y,
)


# 3. Train the model
model = LogisticRegression()
model.fit(X_train, y_train)


# 4. Evaluate on training and unseen test data
train_predictions = model.predict(X_train)
test_predictions = model.predict(X_test)

train_accuracy = accuracy_score(y_train, train_predictions)
test_accuracy = accuracy_score(y_test, test_predictions)


# 5. Extract the learned parameters
weights = model.coef_[0]
bias = model.intercept_[0]


# 6. Manually calculate one prediction
sample = X_test[0]

score = float(np.dot(weights, sample) + bias)
probability = float(1 / (1 + np.exp(-score)))
predicted_class = int(probability >= 0.5)
actual_class = int(y_test[0])


# 7. Save parameters and test sample for the C program
# Calculate Python reference results for every held-out test sample.
test_samples = []

for test_sample, actual in zip(X_test, y_test):
    test_score = float(np.dot(weights, test_sample) + bias)
    test_probability = float(1 / (1 + np.exp(-test_score)))
    test_prediction = int(test_probability >= 0.5)

    test_samples.append({
        "input": [float(x) for x in test_sample],
        "linear_score": test_score,
        "probability": test_probability,
        "predicted_class": test_prediction,
        "actual_class": int(actual),
    })
project_root = Path(__file__).resolve().parents[1]
output_path = project_root / "results" / "model_parameters.json"

model_data = {
    "weights": [float(w) for w in weights],
    "bias": float(bias),
    "test_sample": [float(x) for x in sample],
    "linear_score": score,
    "probability": probability,
    "predicted_class": predicted_class,
    "actual_class": actual_class,
    "test_samples": test_samples,
}

output_path.parent.mkdir(parents=True, exist_ok=True)

with output_path.open("w", encoding="utf-8") as file:
    json.dump(model_data, file, indent=4)


# Also export parameters for the C implementation.
text_path = project_root / "results" / "model_parameters.txt"

with text_path.open("w", encoding="utf-8") as file:
    values = [
        *weights,
        bias,
        *sample,
    ]

    for value in values:
        file.write(f"{value:.17g}\n")

print(f"C parameters saved to: {text_path}")

# 8. Display results
print("MODEL DETECTIVE - PHASE 2")
print("-" * 35)

print(f"Training accuracy: {train_accuracy:.4f}")
print(f"Test accuracy:     {test_accuracy:.4f}")

print("\nLEARNED PARAMETERS")
print(f"Weight 1: {weights[0]:.8f}")
print(f"Weight 2: {weights[1]:.8f}")
print(f"Bias:     {bias:.8f}")

print("\nONE TEST PREDICTION")
print(f"Input:         {sample}")
print(f"Linear score:  {score:.8f}")
print(f"Probability:   {probability:.8f}")
print(f"Predicted:     {predicted_class}")
print(f"Actual:        {actual_class}")

print(f"\nParameters saved to: {output_path}")
