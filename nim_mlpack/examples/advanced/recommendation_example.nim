import mlpack/core
import mlpack/methods/cf

echo "=== Recommendation System Example: Collaborative Filtering ==="

# 1. Create a User-Item rating matrix
# Typically sparse, but mlpack's CF accepts dense matrices with (User, Item, Rating) rows.
# Each column is (UserId, ItemId, Rating)
var ratings = newMat(3, 10)
# User 0 likes Item 0 and 1
ratings[0, 0] = 0; ratings[1, 0] = 0; ratings[2, 0] = 5
ratings[0, 1] = 0; ratings[1, 1] = 1; ratings[2, 1] = 4
# User 1 likes Item 0
ratings[0, 2] = 1; ratings[1, 2] = 0; ratings[2, 2] = 5
# User 2 likes Item 2
ratings[0, 3] = 2; ratings[1, 3] = 2; ratings[2, 3] = 5

# Fill some more dummy data
for i in 4..<10:
  ratings[0, i] = float(i mod 3)
  ratings[1, i] = float(i mod 5)
  ratings[2, i] = float((i * 7) mod 5 + 1)

echo "Input ratings (User, Item, Rating):"
ratings.print()

# 2. Run Collaborative Filtering
echo "Training CF model and generating recommendations..."
# We want to recommend 2 items for each user
let (output, _) = cf(
    training = ratings,
    recommendations = 2,
    algorithm = "NMF", # Non-negative Matrix Factorization
    rank = 2
)

echo "Recommendations (Columns = Users, Rows = Recommended Item IDs):"
output.print()

echo "Done."
