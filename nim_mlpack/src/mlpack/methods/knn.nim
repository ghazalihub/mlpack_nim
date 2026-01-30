import ../core

{.compile: "knn_wrapper.cpp".}
{.emit: "void mlpack_knn(mlpack::util::Params&, mlpack::util::Timers&);".}
proc mlpack_knn(params: var Params, timers: var Timers) {.importcpp: "mlpack_knn(@)".}

type KNNModel* {.importc: "KNNModel".} = object
proc getKNNModel*(p: var Params, name: cstring): var KNNModel {.importcpp: "#.Get<KNNModel>(std::string(#))".}
proc setKNNModel*(p: var Params, name: cstring, val: KNNModel) {.importcpp: "#.Get<KNNModel>(std::string(#)) = #".}
proc newKNNModel*(): KNNModel {.importcpp: "KNNModel()".}

proc knn*(
    algorithm: string = "dual_tree", # Type of neighbor search: 'naive', 'single_tree', 'dual_tree', 'greedy'.
    epsilon: float64 = 0, # If specified, will do approximate nearest neighbor search with given relative error.
    input_model: KNNModel = newKNNModel(), # Pre-trained kNN model.
    k: int = 0, # Number of nearest neighbors to find.
    leaf_size: int = 20, # Leaf size for tree building (used for kd-trees, vp trees, random projection trees, UB trees, R trees, R* trees, X trees, Hilbert R trees, R+ trees, R++ trees, spill trees, and octrees).
    query: Mat = newMat(), # Matrix containing query points (optional).
    random_basis: bool = false, # Before tree-building, project the data onto a random orthogonal basis.
    reference: Mat = newMat(), # Matrix containing the reference dataset.
    rho: float64 = 0.7, # Balance threshold (only valid for spill trees).
    seed: int = 0, # Random seed (if 0, std::time(NULL) is used).
    tau: float64 = 0, # Overlapping size (only valid for spill trees).
    tree_type: string = "kd", # Type of tree to use: 'kd', 'vp', 'rp', 'max-rp', 'ub', 'cover', 'r', 'r-star', 'x', 'ball', 'hilbert-r', 'r-plus', 'r-plus-plus', 'spill', 'oct'.
    true_distances: Mat = newMat(), # Matrix of true distances to compute the effective error (average relative error) (it is printed when -v is specified).
    true_neighbors: UMat = newUMat(), # Matrix of true neighbors to compute the recall (it is printed when -v is specified).
): tuple[distances: Mat, neighbors: UMat, output_model: KNNModel] =
  var params = newParams("knn")
  var timers = newTimers()
  setCppString(params, "algorithm", toCppString(algorithm))
  setPassed(params, "algorithm")
  setDouble(params, "epsilon", epsilon)
  setPassed(params, "epsilon")
  setKNNModel(params, "input_model", input_model)
  setPassed(params, "input_model")
  setInt(params, "k", k)
  setPassed(params, "k")
  setInt(params, "leaf_size", leaf_size)
  setPassed(params, "leaf_size")
  setMat(params, "query", query)
  setPassed(params, "query")
  setBool(params, "random_basis", random_basis)
  setPassed(params, "random_basis")
  setMat(params, "reference", reference)
  setPassed(params, "reference")
  setDouble(params, "rho", rho)
  setPassed(params, "rho")
  setInt(params, "seed", seed)
  setPassed(params, "seed")
  setDouble(params, "tau", tau)
  setPassed(params, "tau")
  setCppString(params, "tree_type", toCppString(tree_type))
  setPassed(params, "tree_type")
  setMat(params, "true_distances", true_distances)
  setPassed(params, "true_distances")
  setUMat(params, "true_neighbors", true_neighbors)
  setPassed(params, "true_neighbors")
  setPassed(params, "distances")
  setPassed(params, "neighbors")
  setPassed(params, "output_model")
  mlpack_knn(params, timers)
  result.distances = getMat(params, "distances")
  result.neighbors = getUMat(params, "neighbors")
  result.output_model = getKNNModel(params, "output_model")
