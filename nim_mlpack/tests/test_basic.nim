import mlpack/core
import mlpack/methods/pca
import mlpack/methods/kmeans

proc testPCA() =
  echo "Testing PCA..."
  var m = newMat()
  m.randu(5, 10)
  let res = pca(input = m, new_dimensionality = 2)
  assert res.n_rows == 2
  assert res.n_cols == 10
  echo "PCA test passed."

proc testKMeans() =
  echo "Testing K-Means..."
  var m = newMat()
  m.randu(2, 20)
  let (centroids, assignments) = kmeans(clusters = 2, input = m)
  assert centroids.n_rows == 2
  assert centroids.n_cols == 2
  echo "K-Means test passed."

testPCA()
testKMeans()
echo "All tests passed!"
