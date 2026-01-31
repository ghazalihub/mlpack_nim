import mlpack/core
import mlpack/methods/pca
import mlpack/methods/kmeans
import mlpack/methods/logistic_regression
import mlpack/methods/preprocess_split

proc testPCA() =
  echo "Testing PCA..."
  var m = newMat(5, 10)
  m.randu(5, 10)
  let res = pca(input = m, new_dimensionality = 2)
  assert res.n_rows == 2
  assert res.n_cols == 10
  echo "PCA test passed."

proc testKMeans() =
  echo "Testing K-Means..."
  var m = newMat(2, 20)
  m.randu(2, 20)
  let (centroids, assignments) = kmeans(clusters = 2, input = m)
  assert centroids.n_rows == 2
  assert centroids.n_cols == 2
  echo "K-Means test passed."

proc testLogisticRegression() =
  echo "Testing Logistic Regression..."
  var data = newMat(3, 50)
  data.randu(3, 50)
  var labels = newUMat(1, 50)
  for i in 0..<50: labels[0, i] = (if data[0, i] > 0.5: 1 else: 0)

  let model = logistic_regression(training = data, labels = labels)
  let (preds, probs) = logistic_regression(input_model = model, test = data)
  assert preds.n_cols == 50
  echo "Logistic Regression test passed."

testPCA()
testKMeans()
testLogisticRegression()
echo "All basic and advanced logic tests passed!"
