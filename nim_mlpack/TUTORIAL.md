# mlpack-nim: From Beginner to Pro

This tutorial provides a deep dive into using `mlpack-nim` for machine learning. We will cover everything from basic setup to deploying complex models.

## Table of Contents
1.  [Setup and Environment](#setup-and-environment)
2.  [Mastering Matrices (Armadillo)](#mastering-matrices)
3.  [Data Preprocessing Pipelines](#data-preprocessing-pipelines)
4.  [Supervised Learning: Classification](#supervised-learning)
5.  [Unsupervised Learning: Clustering](#unsupervised-learning)
6.  [Collaborative Filtering (Recommendation Systems)](#collaborative-filtering)
7.  [Handling Persistent Models](#handling-persistent-models)
8.  [Performance Tips](#performance-tips)

---

## 1. Setup and Environment

`mlpack-nim` leverages the C++ backend of Nim to provide zero-overhead bindings.

### Prerequisites
-   **Nim**: 1.6.0 or higher.
-   **mlpack**: Development headers and library.
-   **Armadillo**: Required for matrix operations.

### Installation (Ubuntu)
```bash
sudo apt install libmlpack-dev libarmadillo-dev
```

### Compiler Flags
When compiling your Nim project, you must use the C++ backend:
```bash
nim cpp -p:path/to/nim_mlpack/src -d:release my_code.nim
```

---

## 2. Mastering Matrices

In `mlpack-nim`, the `Mat` type is your primary data structure. It is a wrapper around `arma::mat`.

### Creation and Initialization
```nim
import mlpack/core

# Empty matrix
var a = newMat()

# 10x10 matrix filled with uniform random values [0, 1]
var b = newMat(10, 10)
b.randu(10, 10)

# Matrix of ones or zeros
var c = newMat()
c.ones(5, 5)
```

### Access and Slicing
```nim
# Single element access (0-indexed)
let val = b[2, 3]
b[0, 0] = 1.23

# Printing for debugging
b.print("Debug Matrix:")
```

> **Note**: mlpack uses column-major format. Typically, each **column** is one observation, and each **row** is one feature.

---

## 3. Data Preprocessing Pipelines

Real-world data is messy. mlpack provides excellent preprocessing tools.

```nim
import mlpack/methods/preprocess_scale
import mlpack/methods/preprocess_split

# Scale data to mean 0 and variance 1
let scaledData = preprocess_scale(input = myData)

# Split into train and test sets (80/20)
let (testData, testLabels, trainData, trainLabels) = preprocess_split(
    input = scaledData,
    input_labels = myLabels,
    test_ratio = 0.2
)
```

---

## 4. Supervised Learning

Let's use a **Random Forest** for classification.

```nim
import mlpack/methods/random_forest

# Train the model
let (model, _) = random_forest(
    training = trainData,
    labels = trainLabels,
    num_trees = 100
)

# Predict on new samples
let (predictions, probabilities) = random_forest(
    input_model = model,
    test = testData
)
```

---

## 5. Unsupervised Learning

**K-Means** is the classic clustering algorithm.

```nim
import mlpack/methods/kmeans

# Cluster into 5 groups
let (centroids, assignments) = kmeans(
    clusters = 5,
    input = myData,
    algorithm = "elkan" # Use Elkan's algorithm for speed
)
```

---

## 6. Collaborative Filtering

Build a recommendation system with ease.

```nim
import mlpack/methods/cf

# 'ratings' matrix with columns as (UserId, ItemId, Rating)
let (recommendations, _) = cf(
    training = ratings,
    recommendations = 5,
    algorithm = "NMF"
)
```

---

## 7. Handling Persistent Models

Models in `mlpack-nim` are robust C++ objects. You can pass them between different steps of your application.

```nim
import mlpack/methods/linear_regression_train
import mlpack/methods/linear_regression_predict

# Phase 1: Training
let myModel = linear_regression_train(training = data, responses = resp)

# Phase 2: Deployment
# You can keep 'myModel' in memory and reuse it for many calls
let pred1 = linear_regression_predict(input_model = myModel, test = samples1)
let pred2 = linear_regression_predict(input_model = myModel, test = samples2)
```

---

## 8. Performance Tips

1.  **Release Mode**: Always compile with `-d:release`. Nim's default mode includes many checks that slow down C++ interop.
2.  **In-place Operations**: Many mlpack methods can work in-place. Check the `API_GUIDE.md` for specific flags.
3.  **Avoid Unnecessary Copies**: When creating large matrices, use `newMat(rows, cols)` and then fill it, rather than creating small pieces and concatenating.
4.  **C++ Exceptions**: mlpack uses exceptions for error handling. Wrapped in Nim, these provide clean backtraces, but catch them if your application must stay alive on bad input.

---

## Next Steps

-   Explore the `examples/` directory for more code.
-   Read the `API_GUIDE.md` for a full list of types.
-   Visit [mlpack.org](https://www.mlpack.org/) for the underlying algorithm documentation.
