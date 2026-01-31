import mlpack/core
import mlpack/methods/random_forest

echo "=== Classification Example: Random Forest ==="

# 1. Create synthetic dataset
# 4 features, 100 samples
var trainData = newMat(4, 100)
trainData.randu(4, 100)

var labels = newUMat(1, 100)
for i in 0..<100:
  # Simple decision boundary
  labels[0, i] = (if trainData[0, i] + trainData[1, i] > 1.0: 1 else: 0)

# 2. Train Random Forest
echo "Training Random Forest with 50 trees..."
let (model, probabilities) = random_forest(
    training = trainData,
    labels = labels,
    num_trees = 50,
    minimum_leaf_size = 1,
    print_training_accuracy = true
)

# 3. Test on new data
var testData = newMat(4, 5)
testData.randu(4, 5)

echo "Predicting on test data..."
let (predictions, _) = random_forest(
    input_model = model,
    test = testData
)

echo "Predictions for 5 samples:"
predictions.print()

echo "Example finished."
