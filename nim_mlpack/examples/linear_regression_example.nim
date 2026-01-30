import mlpack/core
import mlpack/methods/linear_regression_train
import mlpack/methods/linear_regression_predict

echo "Linear Regression Example"

# Create training data
var trainData = newMat()
trainData.randu(5, 100) # 5 features, 100 samples

var responses = newMat()
responses.randu(1, 100) # 1 response

# Train model
echo "Training model..."
let model = linear_regression_train(training = trainData, responses = responses)

# Predict
echo "Predicting..."
var testData = newMat()
testData.randu(5, 10) # 10 test samples

let predictions = linear_regression_predict(input_model = model, test = testData)

echo "Predictions:"
predictions.print()
