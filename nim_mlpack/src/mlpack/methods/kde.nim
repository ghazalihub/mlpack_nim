import ../core

{.compile: "kde_wrapper.cpp".}
{.emit: "void mlpack_kde(mlpack::util::Params&, mlpack::util::Timers&);".}
proc mlpack_kde(params: var Params, timers: var Timers) {.importcpp: "mlpack_kde(@)".}

type KDEModel* {.importc: "KDEModel".} = object
proc getKDEModel*(p: var Params, name: cstring): var KDEModel {.importcpp: "#.Get<KDEModel>(std::string(#))".}
proc setKDEModel*(p: var Params, name: cstring, val: KDEModel) {.importcpp: "#.Get<KDEModel>(std::string(#)) = #".}
proc newKDEModel*(): KDEModel {.importcpp: "KDEModel()".}

proc kde*(
    abs_error: float64 = 0, # Relative error tolerance for the prediction.
    algorithm: string = "dual-tree", # Algorithm to use for the prediction.('dual-tree', 'single-tree').
    bandwidth: float64 = 1, # Bandwidth of the kernel.
    initial_sample_size: int = 100, # Initial sample size for Monte Carlo estimations.
    input_model: KDEModel = newKDEModel(), # Contains pre-trained KDE model.
    kernel: string = "gaussian", # Kernel to use for the prediction.('gaussian', 'epanechnikov', 'laplacian', 'spherical', 'triangular').
    mc_break_coef: float64 = 0.4, # Controls what fraction of the amount of node's descendants is the limit for the sample size before it recurses.
    mc_entry_coef: float64 = 3, # Controls how much larger does the amount of node descendants has to be compared to the initial sample size in order to be a candidate for Monte Carlo estimations.
    mc_probability: float64 = 0.95, # Probability of the estimation being bounded by relative error when using Monte Carlo estimations.
    monte_carlo: bool = false, # Whether to use Monte Carlo estimations when possible.
    query: Mat = newMat(), # Query dataset to KDE on.
    reference: Mat = newMat(), # Input reference dataset use for KDE.
    rel_error: float64 = 0.05, # Relative error tolerance for the prediction.
    tree: string = "kd-tree", # Tree to use for the prediction.('kd-tree', 'ball-tree', 'cover-tree', 'octree', 'r-tree').
): tuple[output_model: KDEModel, predictions: Vec] =
  var params = newParams("kde")
  var timers = newTimers()
  setDouble(params, "abs_error", abs_error)
  setPassed(params, "abs_error")
  setCppString(params, "algorithm", toCppString(algorithm))
  setPassed(params, "algorithm")
  setDouble(params, "bandwidth", bandwidth)
  setPassed(params, "bandwidth")
  setInt(params, "initial_sample_size", initial_sample_size)
  setPassed(params, "initial_sample_size")
  setKDEModel(params, "input_model", input_model)
  setPassed(params, "input_model")
  setCppString(params, "kernel", toCppString(kernel))
  setPassed(params, "kernel")
  setDouble(params, "mc_break_coef", mc_break_coef)
  setPassed(params, "mc_break_coef")
  setDouble(params, "mc_entry_coef", mc_entry_coef)
  setPassed(params, "mc_entry_coef")
  setDouble(params, "mc_probability", mc_probability)
  setPassed(params, "mc_probability")
  setBool(params, "monte_carlo", monte_carlo)
  setPassed(params, "monte_carlo")
  setMat(params, "query", query)
  setPassed(params, "query")
  setMat(params, "reference", reference)
  setPassed(params, "reference")
  setDouble(params, "rel_error", rel_error)
  setPassed(params, "rel_error")
  setCppString(params, "tree", toCppString(tree))
  setPassed(params, "tree")
  setPassed(params, "output_model")
  setPassed(params, "predictions")
  mlpack_kde(params, timers)
  result.output_model = getKDEModel(params, "output_model")
  result.predictions = getVec(params, "predictions")
