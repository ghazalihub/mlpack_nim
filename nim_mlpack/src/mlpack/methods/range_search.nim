import ../core

{.compile: "range_search_wrapper.cpp".}
{.emit: "void mlpack_range_search(mlpack::util::Params&, mlpack::util::Timers&);".}
proc mlpack_range_search(params: var Params, timers: var Timers) {.importcpp: "mlpack_range_search(@)".}

type RSModel* {.importc: "RSModel".} = object
proc getRSModel*(p: var Params, name: cstring): var RSModel {.importcpp: "#.Get<RSModel>(std::string(#))".}
proc setRSModel*(p: var Params, name: cstring, val: RSModel) {.importcpp: "#.Get<RSModel>(std::string(#)) = #".}
proc newRSModel*(): RSModel {.importcpp: "RSModel()".}

proc range_search*(
    input_model: RSModel = newRSModel(), # File containing pre-trained range search model.
    leaf_size: int = 20, # Leaf size for tree building (used for kd-trees, vp trees, random projection trees, UB trees, R trees, R* trees, X trees, Hilbert R trees, R+ trees, R++ trees, and octrees).
    max: float64 = 0, # Upper bound in range (if not specified, +inf will be used.
    min: float64 = 0, # Lower bound in range.
    naive: bool = false, # If true, O(n^2) naive mode is used for computation.
    query: Mat = newMat(), # File containing query points (optional).
    random_basis: bool = false, # Before tree-building, project the data onto a random orthogonal basis.
    reference: Mat = newMat(), # Matrix containing the reference dataset.
    seed: int = 0, # Random seed (if 0, std::time(NULL) is used).
    single_mode: bool = false, # If true, single-tree search is used (as opposed to dual-tree search).
    tree_type: string = "kd", # Type of tree to use: 'kd', 'vp', 'rp', 'max-rp', 'ub', 'cover', 'r', 'r-star', 'x', 'ball', 'hilbert-r', 'r-plus', 'r-plus-plus', 'oct'.
): tuple[distances_file: string, neighbors_file: string, output_model: RSModel] =
  var params = newParams("range_search")
  var timers = newTimers()
  setRSModel(params, "input_model", input_model)
  setPassed(params, "input_model")
  setInt(params, "leaf_size", leaf_size)
  setPassed(params, "leaf_size")
  setDouble(params, "max", max)
  setPassed(params, "max")
  setDouble(params, "min", min)
  setPassed(params, "min")
  setBool(params, "naive", naive)
  setPassed(params, "naive")
  setMat(params, "query", query)
  setPassed(params, "query")
  setBool(params, "random_basis", random_basis)
  setPassed(params, "random_basis")
  setMat(params, "reference", reference)
  setPassed(params, "reference")
  setInt(params, "seed", seed)
  setPassed(params, "seed")
  setBool(params, "single_mode", single_mode)
  setPassed(params, "single_mode")
  setCppString(params, "tree_type", toCppString(tree_type))
  setPassed(params, "tree_type")
  setPassed(params, "distances_file")
  setPassed(params, "neighbors_file")
  setPassed(params, "output_model")
  mlpack_range_search(params, timers)
  result.distances_file = $(getCppString(params, "distances_file"))
  result.neighbors_file = $(getCppString(params, "neighbors_file"))
  result.output_model = getRSModel(params, "output_model")
