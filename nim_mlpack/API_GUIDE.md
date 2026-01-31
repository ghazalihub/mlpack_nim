# mlpack-nim API Guide

This guide provides a detailed look at the `mlpack-nim` API, its types, and how it interacts with the underlying C++ library.

## Core Types

### Matrix and Vector Types
We use `arma::mat` and its variants for data representation. These are mapped as follows:

| Nim Type | C++ Equivalent | Description |
|---|---|---|
| `Mat` | `arma::mat` | Dense matrix (double precision) |
| `Vec` | `arma::vec` | Column vector (double precision) |
| `Row` | `arma::rowvec` | Row vector (double precision) |
| `UMat` | `arma::Mat<size_t>` | Dense matrix (unsigned integers) |
| `UVec` | `arma::Col<size_t>` | Column vector (unsigned integers) |

#### Basic Operations
- `newMat(rows, cols)`: Create a new matrix.
- `m[r, c]`: Get/set elements.
- `m.n_rows`, `m.n_cols`: Get dimensions.
- `m.randu(rows, cols)`: Fill with uniform random values.
- `m.randn(rows, cols)`: Fill with normal random values.
- `m.print(header)`: Print the matrix to console.

### Parameter Management
- `Params`: Wraps `mlpack::util::Params`. It's used internally by all method bindings but can be accessed for advanced usage.
- `Timers`: Wraps `mlpack::util::Timers` for performance measurement.

---

## Method Bindings Pattern

All mlpack methods follow a consistent pattern in Nim:

```nim
proc methodName*(
    param1: Type1 = defaultValue1,
    param2: Type2 = defaultValue2,
    ...
): ReturnType
```

### Named Parameters
Nim's named parameter support is used to provide an API that matches the mlpack CLI/Python experience:

```nim
let result = pca(input = myData, new_dimensionality = 2, scale = true)
```

### Multiple Return Values
Methods that return multiple outputs (e.g., KNN returning both distances and neighbor indices) use Nim tuples:

```nim
let (distances, neighbors, model) = knn(reference = refData, k = 5)
```

---

## Working with Models

Many algorithms (like Random Forest or Linear Regression) produce a trained "Model" object.

### The Model Object
In Nim, these are represented as C++ objects. You don't usually need to inspect them directly; instead, you pass them between methods.

```nim
# Train
let model = linear_regression_train(training = trainData, responses = responses)

# Use (Predict)
let predictions = linear_regression_predict(input_model = model, test = testData)
```

### Custom Type Definitions
Each method that uses a model defines its own model type (e.g., `RandomForestModel`, `KNNModel`). These are automatically handled by the bindings.

---

## Advanced C++ Interop

The library is built on top of Nim's C++ backend. You can include custom C++ code using `{.emit.}` or `{.passC.}` if you need to extend functionality beyond the provided bindings.

### Passing Flags
Boolean parameters in Nim (e.g., `scale = true`) are correctly mapped to mlpack flags.

### Strings
Strings are automatically converted between Nim strings and `std::string` using `toCppString()` and `$`.

---

## Best Practices

1.  **Memory Management**: Since we are using the C++ backend, matrices and models are managed by C++'s RAII. Nim's GC handles the wrappers.
2.  **Dataset Orientation**: mlpack generally expects datasets where **observations are columns** and **features are rows**. This is consistent with Armadillo's orientation.
3.  **Error Handling**: mlpack uses C++ exceptions. These will propagate as Nim exceptions. Look for `[FATAL]` logs in the console for detailed error messages from mlpack.
