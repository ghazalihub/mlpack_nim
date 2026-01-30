import ../core

{.compile: "dbscan_wrapper.cpp".}
{.emit: "void mlpack_dbscan(mlpack::util::Params&, mlpack::util::Timers&);".}
proc mlpack_dbscan(params: var Params, timers: var Timers) {.importcpp: "mlpack_dbscan(@)".}

type arma::Row_size_t_* {.importc: "arma::Row<size_t>".} = object
proc getarma::Row_size_t_*(p: var Params, name: cstring): var arma::Row_size_t_ {.importcpp: "#.Get<arma::Row<size_t>>(std::string(#))".}
proc setarma::Row_size_t_*(p: var Params, name: cstring, val: arma::Row_size_t_) {.importcpp: "#.Get<arma::Row<size_t>>(std::string(#)) = #".}
proc newarma::Row_size_t_*(): arma::Row_size_t_ {.importcpp: "arma::Row<size_t>()".}

proc dbscan*(
    epsilon: float64 = 1, # Radius of each range search.
    input: Mat, # Input dataset to cluster.
    min_size: int = 5, # Minimum number of points for a cluster.
    naive: bool = false, # If set, brute-force range search (not tree-based) will be used.
    selection_type: string = "ordered", # If using point selection policy, the type of selection to use ('ordered', 'random').
    single_mode: bool = false, # If set, single-tree range search (not dual-tree) will be used.
    tree_type: string = "kd", # If using single-tree or dual-tree search, the type of tree to use ('kd', 'r', 'r-star', 'x', 'hilbert-r', 'r-plus', 'r-plus-plus', 'cover', 'ball').
): tuple[assignments: arma::Row_size_t_, centroids: Mat] =
  var params = newParams("dbscan")
  var timers = newTimers()
  setDouble(params, "epsilon", epsilon)
  setPassed(params, "epsilon")
  setMat(params, "input", input)
  setPassed(params, "input")
  setInt(params, "min_size", min_size)
  setPassed(params, "min_size")
  setBool(params, "naive", naive)
  setPassed(params, "naive")
  setCppString(params, "selection_type", toCppString(selection_type))
  setPassed(params, "selection_type")
  setBool(params, "single_mode", single_mode)
  setPassed(params, "single_mode")
  setCppString(params, "tree_type", toCppString(tree_type))
  setPassed(params, "tree_type")
  setPassed(params, "assignments")
  setPassed(params, "centroids")
  mlpack_dbscan(params, timers)
  result.assignments = getarma::Row_size_t_(params, "assignments")
  result.centroids = getMat(params, "centroids")
