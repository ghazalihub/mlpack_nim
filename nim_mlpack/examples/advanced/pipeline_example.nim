import mlpack/core
import mlpack/methods/preprocess_scale
import mlpack/methods/preprocess_split
import mlpack/methods/logistic_regression
import std/strutils

echo "=== Pipeline Example: Logistic Regression ==="

# 1. Generate some synthetic data (10 features, 200 samples)
var dataset = newMat(10, 200)
dataset.randu(10, 200)

# Labels (0 or 1)
var labels = newUMat(1, 200)
for i in 0..<200:
  labels[0, i] = (if dataset[0, i] > 0.5: 1 else: 0)

# 2. Preprocess: Scale features to have mean 0 and variance 1
echo "Scaling data..."
let scaledData = preprocess_scale(input = dataset)

# 3. Split: Training (80%) and Test (20%)
echo "Splitting into train/test sets..."
let (test_data, test_labels, train_data, train_labels) = preprocess_split(
    input = scaledData,
    input_labels = labels,
    test_ratio = 0.2
)

echo "Train size: ", train_data.n_cols
echo "Test size: ", test_data.n_cols

# 4. Train: Logistic Regression
echo "Training Logistic Regression model..."
let model = logistic_regression(training = train_data, labels = train_labels)

# 5. Evaluate: Predict on test data
echo "Predicting on test set..."
let (predictions, probabilities) = logistic_regression(
    input_model = model,
    test = test_data
)

# Calculate accuracy
var correct = 0
for i in 0..<test_labels.n_cols:
  if predictions[0, i] == test_labels[0, i]:
    inc correct

let accuracy = float(correct) / float(test_labels.n_cols)
echo "Test Accuracy: ", formatFloat(accuracy * 100, ffDecimal, 2), "%"
