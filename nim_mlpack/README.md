# mlpack-nim: Really Great mlpack Bindings for Nim

This library provides high-quality, automatically generated Nim bindings for [mlpack](https://www.mlpack.org/), a fast, flexible machine learning library written in C++.

## Features

- **Direct Integration**: Use mlpack algorithms directly in Nim.
- **Idiomatic API**: Nim functions use named parameters and default values, making them easy to use.
- **Armadillo Support**: Uses the powerful Armadillo library for matrix operations.
- **Automated Bindings**: Generated from mlpack's core, ensuring compatibility and coverage.
- **Zero Overhead**: Direct C++ interop with no performance penalty.

## Installation

### Prerequisites

You need `mlpack` and `armadillo` installed on your system.

**Ubuntu/Debian:**
```bash
sudo apt install libmlpack-dev libarmadillo-dev
```

### Adding to your project

Add `nim_mlpack` to your `.nimble` file or include it in your project path.

## Quick Start

```nim
import mlpack/core
import mlpack/methods/pca

# Create some random data (10 features, 100 samples)
var data = newMat()
data.randu(10, 100)

# Run PCA to reduce to 2 dimensions
let result = pca(input = data, new_dimensionality = 2)

echo "Reduced dimensions: ", result.n_rows, "x", result.n_cols
result.print("PCA Result:")
```

## Supported Methods

Almost all 50+ mlpack methods are supported, including:
- PCA
- K-Means
- K-Nearest Neighbors (KNN)
- Linear Regression
- Random Forest
- Softmax Regression
- DBSCAN
- And many more...

## License
BSD 3-Clause (Same as mlpack)
