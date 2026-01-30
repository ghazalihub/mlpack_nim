import ../core

{.compile: "kfn_wrapper.cpp".}
{.emit: "void mlpack_kfn(mlpack::util::Params&, mlpack::util::Timers&);".}
proc mlpack_kfn(params: var Params, timers: var Timers) {.importcpp: "mlpack_kfn(@)".}

type KFNModel* {.importc: "KFNModel".} = object
proc getKFNModel*(p: var Params, name: cstring): var KFNModel {.importcpp: "#.Get<KFNModel>(std::string(#))".}
proc setKFNModel*(p: var Params, name: cstring, val: KFNModel) {.importcpp: "#.Get<KFNModel>(std::string(#)) = #".}
proc newKFNModel*(): KFNModel {.importcpp: "KFNModel()".}

proc kfn*(
    algorithm: string = "dual_tree", # Type of neighbor search: 'naive', 'single_tree', 'dual_tree', 'greedy'.
    epsilon: float64 = 0, # If specified, will do approximate furthest neighbor search with given relative error. Must be in the range [0,1).
    input_model: KFNModel = newKFNModel(), # Pre-trained kFN model.
    k: int = 0, # Number of furthest neighbors to find.
    leaf_size: int = 20, # Leaf size for tree building (used for kd-trees, vp trees, random projection trees, UB trees, R trees, R* trees, X trees, Hilbert R trees, R+ trees, R++ trees, and octrees).
    percentage: float64 = 1, # If specified, will do approximate furthest neighbor search. Must be in the range (0,1] (decimal form). Resultant neighbors will be at least (p*100) % of the distance as the true furthest neighbor.
    query: Mat = newMat(), # Matrix containing query points (optional).
    random_basis: bool = false, # Before tree-building, project the data onto a random orthogonal basis.
    reference: Mat = newMat(), # Matrix containing the reference dataset.
    seed: int = 0, # Random seed (if 0, std::time(NULL) is used).
    tree_type: string = "kd", # Type of tree to use: 'kd', 'vp', 'rp', 'max-rp', 'ub', 'cover', 'r', 'r-star', 'x', 'ball', 'hilbert-r', 'r-plus', 'r-plus-plus', 'oct'.
    true_distances: Mat = newMat(), # Matrix of true distances to compute the effective error (average relative error) (it is printed when -v is specified).
    true_neighbors: UMat = newUMat(), # Matrix of true neighbors to compute the recall (it is printed when -v is specified).
): tuple[distances: Mat, neighbors: UMat, output_model: KFNModel] =
  var params = newParams("kfn")
  var timers = newTimers()
  setCppString(params, "algorithm", toCppString(algorithm))
  setPassed(params, "algorithm")
  setDouble(params, "epsilon", epsilon)
  setPassed(params, "epsilon")
  setKFNModel(params, "input_model", input_model)
  setPassed(params, "input_model")
  setInt(params, "k", k)
  setPassed(params, "k")
  setInt(params, "leaf_size", leaf_size)
  setPassed(params, "leaf_size")
  setDouble(params, "percentage", percentage)
  setPassed(params, "percentage")
  setMat(params, "query", query)
  setPassed(params, "query")
  setBool(params, "random_basis", random_basis)
  setPassed(params, "random_basis")
  setMat(params, "reference", reference)
  setPassed(params, "reference")
  setInt(params, "seed", seed)
  setPassed(params, "seed")
  setCppString(params, "tree_type", toCppString(tree_type))
  setPassed(params, "tree_type")
  setMat(params, "true_distances", true_distances)
  setPassed(params, "true_distances")
  setUMat(params, "true_neighbors", true_neighbors)
  setPassed(params, "true_neighbors")
  setPassed(params, "distances")
  setPassed(params, "neighbors")
  setPassed(params, "output_model")
  mlpack_kfn(params, timers)
  result.distances = getMat(params, "distances")
  result.neighbors = getUMat(params, "neighbors")
  result.output_model = getKFNModel(params, "output_model")
