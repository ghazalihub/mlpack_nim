import mlpack/core
import mlpack/methods/pca

echo "PCA Example"

var data = newMat()
data.randu(10, 100) # 10 features, 100 points

echo "Reducing to 2 dimensions..."
let result = pca(input = data, new_dimensionality = 2)

echo "Resulting dimensions: ", result.n_rows, "x", result.n_cols
result.print("PCA results:")
