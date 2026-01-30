# mlpack-nim Tutorial

Welcome to the mlpack-nim tutorial! This guide will show you how to use mlpack for various machine learning tasks using Nim.

## 1. Matrix Operations with Armadillo

mlpack uses the Armadillo library for its matrix operations. In Nim, we provide a wrapper around the `Mat` type.

```nim
import mlpack/core

# Create a 5x5 random matrix
var m = newMat(5, 5)
m.randu(5, 5)

# Element access
let val = m[0, 0]
m[1, 1] = 3.14

# Printing
m.print("My Matrix:")

# Get dimensions
echo "Rows: ", m.n_rows, " Cols: ", m.n_cols
```

## 2. Linear Regression

Linear regression is a simple but powerful tool for predicting numerical values.

```nim
import mlpack/core
import mlpack/methods/linear_regression_train
import mlpack/methods/linear_regression_predict

# Training data (features, samples)
var trainData = newMat(5, 100)
trainData.randu(5, 100)

var responses = newMat(1, 100)
responses.randu(1, 100)

# Train the model
let model = linear_regression_train(training = trainData, responses = responses)

# Predict on new data
var testData = newMat(5, 10)
testData.randu(5, 10)

let predictions = linear_regression_predict(input_model = model, test = testData)
predictions.print("Predictions:")
```

## 3. K-Means Clustering

Group your data into clusters.

```nim
import mlpack/core
import mlpack/methods/kmeans

var data = newMat(2, 500)
data.randu(2, 500)

# Run K-Means
let (centroids, assignments) = kmeans(clusters = 3, input = data)

centroids.print("Centroids:")
```

## 4. K-Nearest Neighbors (KNN)

Find the most similar points in your dataset.

```nim
import mlpack/core
import mlpack/methods/knn

var reference = newMat(3, 100)
reference.randu(3, 100)

var query = newMat(3, 5)
query.randu(3, 5)

# Find 3 nearest neighbors
let (distances, neighbors, _) = knn(reference = reference, query = query, k = 3)

neighbors.print("Neighbor indices:")
```

## Advanced: Working with Models

Many mlpack methods return models that can be saved and reused. The bindings handle these custom C++ types automatically.

```nim
import mlpack/methods/random_forest

# Training...
let model = random_forest(training = trainData, labels = labels, num_trees = 10)

# The 'model' variable holds the C++ RandomForestModel.
# You can pass it back to random_forest or other compatible methods.
```

## Conclusion

mlpack-nim brings the speed of C++ machine learning to the elegance of Nim. Happy hacking!
