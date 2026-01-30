import ../core

{.compile: "lmnn_wrapper.cpp".}
{.emit: "void mlpack_lmnn(mlpack::util::Params&, mlpack::util::Timers&);".}
proc mlpack_lmnn(params: var Params, timers: var Timers) {.importcpp: "mlpack_lmnn(@)".}

type arma::Row_size_t_* {.importc: "arma::Row<size_t>".} = object
proc getarma::Row_size_t_*(p: var Params, name: cstring): var arma::Row_size_t_ {.importcpp: "#.Get<arma::Row<size_t>>(std::string(#))".}
proc setarma::Row_size_t_*(p: var Params, name: cstring, val: arma::Row_size_t_) {.importcpp: "#.Get<arma::Row<size_t>>(std::string(#)) = #".}
proc newarma::Row_size_t_*(): arma::Row_size_t_ {.importcpp: "arma::Row<size_t>()".}

proc lmnn*(
    batch_size: int = 50, # Batch size for mini-batch SGD.
    center: bool = false, # Perform mean-centering on the dataset. It is useful when the centroid of the data is far from the origin.
    distance: Mat = newMat(), # Initial distance matrix to be used as starting point
    input: Mat, # Input dataset to run LMNN on.
    k: int = 1, # Number of target neighbors to use for each datapoint.
    labels: arma::Row_size_t_ = newarma::Row_size_t_(), # Labels for input dataset.
    linear_scan: bool = false, # Don't shuffle the order in which data points are visited for SGD or mini-batch SGD.
    max_iterations: int = 100000, # Maximum number of iterations for L-BFGS (0 indicates no limit).
    normalize: bool = false, # Use a normalized starting point for optimization. Itis useful for when points are far apart, or when SGD is returning NaN.
    optimizer: string = "amsgrad", # Optimizer to use; 'amsgrad', 'bbsgd', 'sgd', or 'lbfgs'.
    passes: int = 50, # Maximum number of full passes over dataset for AMSGrad, BB_SGD and SGD.
    print_accuracy: bool = false, # Print accuracies on initial and transformed dataset
    rank: int = 0, # Rank of distance matrix to be optimized.
    regularization: float64 = 0.5, # Regularization for LMNN objective function
    seed: int = 0, # Random seed.  If 0, 'std::time(NULL)' is used.
    step_size: float64 = 0.01, # Step size for AMSGrad, BB_SGD and SGD (alpha).
    tolerance: float64 = 1e-07, # Maximum tolerance for termination of AMSGrad, BB_SGD, SGD or L-BFGS.
    update_interval: int = 1, # Number of iterations after which impostors need to be recalculated.
): tuple[centered_data: Mat, output: Mat, transformed_data: Mat] =
  var params = newParams("lmnn")
  var timers = newTimers()
  setInt(params, "batch_size", batch_size)
  setPassed(params, "batch_size")
  setBool(params, "center", center)
  setPassed(params, "center")
  setMat(params, "distance", distance)
  setPassed(params, "distance")
  setMat(params, "input", input)
  setPassed(params, "input")
  setInt(params, "k", k)
  setPassed(params, "k")
  setarma::Row_size_t_(params, "labels", labels)
  setPassed(params, "labels")
  setBool(params, "linear_scan", linear_scan)
  setPassed(params, "linear_scan")
  setInt(params, "max_iterations", max_iterations)
  setPassed(params, "max_iterations")
  setBool(params, "normalize", normalize)
  setPassed(params, "normalize")
  setCppString(params, "optimizer", toCppString(optimizer))
  setPassed(params, "optimizer")
  setInt(params, "passes", passes)
  setPassed(params, "passes")
  setBool(params, "print_accuracy", print_accuracy)
  setPassed(params, "print_accuracy")
  setInt(params, "rank", rank)
  setPassed(params, "rank")
  setDouble(params, "regularization", regularization)
  setPassed(params, "regularization")
  setInt(params, "seed", seed)
  setPassed(params, "seed")
  setDouble(params, "step_size", step_size)
  setPassed(params, "step_size")
  setDouble(params, "tolerance", tolerance)
  setPassed(params, "tolerance")
  setInt(params, "update_interval", update_interval)
  setPassed(params, "update_interval")
  setPassed(params, "centered_data")
  setPassed(params, "output")
  setPassed(params, "transformed_data")
  mlpack_lmnn(params, timers)
  result.centered_data = getMat(params, "centered_data")
  result.output = getMat(params, "output")
  result.transformed_data = getMat(params, "transformed_data")
