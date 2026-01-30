import ../core

{.compile: "krann_wrapper.cpp".}
{.emit: "void mlpack_krann(mlpack::util::Params&, mlpack::util::Timers&);".}
proc mlpack_krann(params: var Params, timers: var Timers) {.importcpp: "mlpack_krann(@)".}

type RAModel* {.importc: "RAModel".} = object
proc getRAModel*(p: var Params, name: cstring): var RAModel {.importcpp: "#.Get<RAModel>(std::string(#))".}
proc setRAModel*(p: var Params, name: cstring, val: RAModel) {.importcpp: "#.Get<RAModel>(std::string(#)) = #".}
proc newRAModel*(): RAModel {.importcpp: "RAModel()".}

proc krann*(
    alpha: float64 = 0.95, # The desired success probability.
    first_leaf_exact: bool = false, # The flag to trigger sampling only after exactly exploring the first leaf.
    input_model: RAModel = newRAModel(), # Pre-trained kNN model.
    k: int = 0, # Number of nearest neighbors to find.
    leaf_size: int = 20, # Leaf size for tree building (used for kd-trees, UB trees, R trees, R* trees, X trees, Hilbert R trees, R+ trees, R++ trees, and octrees).
    naive: bool = false, # If true, sampling will be done without using a tree.
    query: Mat = newMat(), # Matrix containing query points (optional).
    random_basis: bool = false, # Before tree-building, project the data onto a random orthogonal basis.
    reference: Mat = newMat(), # Matrix containing the reference dataset.
    sample_at_leaves: bool = false, # The flag to trigger sampling at leaves.
    seed: int = 0, # Random seed (if 0, std::time(NULL) is used).
    single_mode: bool = false, # If true, single-tree search is used (as opposed to dual-tree search.
    single_sample_limit: int = 20, # The limit on the maximum number of samples (and hence the largest node you can approximate).
    tau: float64 = 5, # The allowed rank-error in terms of the percentile of the data.
    tree_type: string = "kd", # Type of tree to use: 'kd', 'ub', 'cover', 'r', 'x', 'r-star', 'hilbert-r', 'r-plus', 'r-plus-plus', 'oct'.
): tuple[distances: Mat, neighbors: UMat, output_model: RAModel] =
  var params = newParams("krann")
  var timers = newTimers()
  setDouble(params, "alpha", alpha)
  setPassed(params, "alpha")
  setBool(params, "first_leaf_exact", first_leaf_exact)
  setPassed(params, "first_leaf_exact")
  setRAModel(params, "input_model", input_model)
  setPassed(params, "input_model")
  setInt(params, "k", k)
  setPassed(params, "k")
  setInt(params, "leaf_size", leaf_size)
  setPassed(params, "leaf_size")
  setBool(params, "naive", naive)
  setPassed(params, "naive")
  setMat(params, "query", query)
  setPassed(params, "query")
  setBool(params, "random_basis", random_basis)
  setPassed(params, "random_basis")
  setMat(params, "reference", reference)
  setPassed(params, "reference")
  setBool(params, "sample_at_leaves", sample_at_leaves)
  setPassed(params, "sample_at_leaves")
  setInt(params, "seed", seed)
  setPassed(params, "seed")
  setBool(params, "single_mode", single_mode)
  setPassed(params, "single_mode")
  setInt(params, "single_sample_limit", single_sample_limit)
  setPassed(params, "single_sample_limit")
  setDouble(params, "tau", tau)
  setPassed(params, "tau")
  setCppString(params, "tree_type", toCppString(tree_type))
  setPassed(params, "tree_type")
  setPassed(params, "distances")
  setPassed(params, "neighbors")
  setPassed(params, "output_model")
  mlpack_krann(params, timers)
  result.distances = getMat(params, "distances")
  result.neighbors = getUMat(params, "neighbors")
  result.output_model = getRAModel(params, "output_model")
