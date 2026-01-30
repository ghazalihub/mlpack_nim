import mlpack/core
import mlpack/methods/knn

echo "K-Nearest Neighbors Example"

var referenceData = newMat()
referenceData.randu(3, 100) # 3D data, 100 points

var queryData = newMat()
queryData.randu(3, 5) # 5 query points

echo "Finding 3 nearest neighbors..."
let (distances, neighbors, _) = knn(reference = referenceData, query = queryData, k = 3)

echo "Neighbor indices:"
neighbors.print()

echo "Distances:"
distances.print()
