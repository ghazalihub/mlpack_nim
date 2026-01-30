import ../core

{.compile: "nca_wrapper.cpp".}
{.emit: "void mlpack_nca(mlpack::util::Params&, mlpack::util::Timers&);".}
proc mlpack_nca(params: var Params, timers: var Timers) {.importcpp: "mlpack_nca(@)".}

type arma::Row_size_t_* {.importc: "arma::Row<size_t>".} = object
proc getarma::Row_size_t_*(p: var Params, name: cstring): var arma::Row_size_t_ {.importcpp: "#.Get<arma::Row<size_t>>(std::string(#))".}
proc setarma::Row_size_t_*(p: var Params, name: cstring, val: arma::Row_size_t_) {.importcpp: "#.Get<arma::Row<size_t>>(std::string(#)) = #".}
proc newarma::Row_size_t_*(): arma::Row_size_t_ {.importcpp: "arma::Row<size_t>()".}

proc nca*(
    armijo_constant: float64 = 0.0001, # Armijo constant for L-BFGS.
    batch_size: int = 50, # Batch size for mini-batch SGD.
    input: Mat, # Input dataset to run NCA on.
    labels: arma::Row_size_t_ = newarma::Row_size_t_(), # Labels for input dataset.
    linear_scan: bool = false, # Don't shuffle the order in which data points are visited for SGD or mini-batch SGD.
    max_iterations: int = 500000, # Maximum number of iterations for SGD or L-BFGS (0 indicates no limit).
    max_line_search_trials: int = 50, # Maximum number of line search trials for L-BFGS.
    max_step: float64 = 1e+20, # Maximum step of line search for L-BFGS.
    min_step: float64 = 1e-20, # Minimum step of line search for L-BFGS.
    normalize: bool = false, # Use a normalized starting point for optimization. This is useful for when points are far apart, or when SGD is returning NaN.
    num_basis: int = 5, # Number of memory points to be stored for L-BFGS.
    optimizer: string = "sgd", # Optimizer to use; 'sgd' or 'lbfgs'.
    seed: int = 0, # Random seed.  If 0, 'std::time(NULL)' is used.
    step_size: float64 = 0.01, # Step size for stochastic gradient descent (alpha).
    tolerance: float64 = 1e-07, # Maximum tolerance for termination of SGD or L-BFGS.
    wolfe: float64 = 0.9, # Wolfe condition parameter for L-BFGS.
): Mat =
  var params = newParams("nca")
  var timers = newTimers()
  setDouble(params, "armijo_constant", armijo_constant)
  setPassed(params, "armijo_constant")
  setInt(params, "batch_size", batch_size)
  setPassed(params, "batch_size")
  setMat(params, "input", input)
  setPassed(params, "input")
  setarma::Row_size_t_(params, "labels", labels)
  setPassed(params, "labels")
  setBool(params, "linear_scan", linear_scan)
  setPassed(params, "linear_scan")
  setInt(params, "max_iterations", max_iterations)
  setPassed(params, "max_iterations")
  setInt(params, "max_line_search_trials", max_line_search_trials)
  setPassed(params, "max_line_search_trials")
  setDouble(params, "max_step", max_step)
  setPassed(params, "max_step")
  setDouble(params, "min_step", min_step)
  setPassed(params, "min_step")
  setBool(params, "normalize", normalize)
  setPassed(params, "normalize")
  setInt(params, "num_basis", num_basis)
  setPassed(params, "num_basis")
  setCppString(params, "optimizer", toCppString(optimizer))
  setPassed(params, "optimizer")
  setInt(params, "seed", seed)
  setPassed(params, "seed")
  setDouble(params, "step_size", step_size)
  setPassed(params, "step_size")
  setDouble(params, "tolerance", tolerance)
  setPassed(params, "tolerance")
  setDouble(params, "wolfe", wolfe)
  setPassed(params, "wolfe")
  setPassed(params, "output")
  mlpack_nca(params, timers)
  result = getMat(params, "output")
