import mlpack/core
import mlpack/methods/kmeans

echo "K-Means Clustering Example"

var data = newMat()
data.randu(2, 500) # 2D data, 500 points

echo "Running K-Means with 3 clusters..."
let (centroids, assignments) = kmeans(clusters = 3, input = data)

echo "Centroids:"
centroids.print()

echo "Found ", centroids.n_cols, " clusters."
