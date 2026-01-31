# mlpack-nim 🚀

**Really great, high-performance Nim bindings for the mlpack machine learning library.**

`mlpack-nim` allows you to leverage the full power of [mlpack](https://www.mlpack.org/)—a fast, flexible C++ machine learning library—directly within your Nim projects. It provides a clean, idiomatic Nim API while maintaining the blistering performance of C++.

---

## Why mlpack-nim?

-   **Performance**: Zero-overhead bindings using Nim's C++ backend.
-   **Simplicity**: Use named parameters and default values for a modern ML experience.
-   **Completeness**: Over 50+ machine learning algorithms supported (PCA, KNN, Random Forests, CF, and more).
-   **Robustness**: Seamlessly pass complex C++ models between Nim functions.
-   **Powered by Armadillo**: Native support for the Armadillo linear algebra library.

---

## Installation

### 1. Install System Dependencies
`mlpack-nim` requires `mlpack` and `armadillo` headers and libraries.

**Ubuntu/Debian:**
```bash
sudo apt install libmlpack-dev libarmadillo-dev
```

### 2. Add to Your Project
Include the `src` directory in your Nim path.

```bash
# In your .nimble file:
requires "nim >= 1.6.0"
```

---

## Quick Start: Principal Component Analysis (PCA)

```nim
import mlpack/core
import mlpack/methods/pca

# 1. Prepare Data (10 features, 100 samples)
var data = newMat(10, 100)
data.randu(10, 100)

# 2. Run PCA (Reduce to 2 dimensions)
let result = pca(input = data, new_dimensionality = 2)

# 3. Print Results
echo "Reduced dimensions: ", result.n_rows, "x", result.n_cols
result.print("PCA Projection:")
```

---

## Documentation

-   [**Tutorial**](TUTORIAL.md): A step-by-step guide from beginner to advanced.
-   [**API Guide**](API_GUIDE.md): Detailed information on types and patterns.
-   [**Examples**](examples/): Practical scripts covering various ML tasks.

---

## Supported Methods (Partial List)

| Category | Methods |
|---|---|
| **Classification** | Random Forest, Decision Tree, Logistic Regression, NBC, AdaBoost |
| **Regression** | Linear Regression, LARS, Bayesian Linear Regression |
| **Clustering** | K-Means, DBSCAN, Mean Shift |
| **Dimensionality Reduction** | PCA, Kernel PCA, NCA, LMNN |
| **Neighbor Search** | KNN, KFN, LSH, Range Search |
| **Preprocessing** | Scaling, Splitting, Imputing, Binarizing |
| **Misc** | CF (Recommendation), HMM, GMM, Radical |

---

## Troubleshooting

-   **Compile Error**: Ensure you use `nim cpp`. This library *requires* the C++ backend.
-   **Missing Headers**: Verify that `libmlpack-dev` and `libarmadillo-dev` are installed.
-   **Linking Issues**: If you use custom library paths, use `{.passL: "-L/path/to/lib".}` in your code.

## License
BSD 3-Clause (Same as mlpack)
