import ../core

{.compile: "mean_shift_wrapper.cpp".}
{.emit: "void mlpack_mean_shift(mlpack::util::Params&, mlpack::util::Timers&);".}
proc mlpack_mean_shift(params: var Params, timers: var Timers) {.importcpp: "mlpack_mean_shift(@)".}

proc mean_shift*(
    force_convergence: bool = false, # If specified, the mean shift algorithm will continue running regardless of max_iterations until the clusters converge.
    in_place: bool = false, # If specified, a column containing the learned cluster assignments will be added to the input dataset file.  In this case, --output_file is overridden.  (Do not use with Python.)
    input: Mat, # Input dataset to perform clustering on.
    labels_only: bool = false, # If specified, only the output labels will be written to the file specified by --output_file.
    max_iterations: int = 1000, # Maximum number of iterations before mean shift terminates.
    radius: float64 = 0, # If the distance between two centroids is less than the given radius, one will be removed.  A radius of 0 or less means an estimate will be calculated and used for the radius.
): tuple[centroid: Mat, output: Mat] =
  var params = newParams("mean_shift")
  var timers = newTimers()
  setBool(params, "force_convergence", force_convergence)
  setPassed(params, "force_convergence")
  setBool(params, "in_place", in_place)
  setPassed(params, "in_place")
  setMat(params, "input", input)
  setPassed(params, "input")
  setBool(params, "labels_only", labels_only)
  setPassed(params, "labels_only")
  setInt(params, "max_iterations", max_iterations)
  setPassed(params, "max_iterations")
  setDouble(params, "radius", radius)
  setPassed(params, "radius")
  setPassed(params, "centroid")
  setPassed(params, "output")
  mlpack_mean_shift(params, timers)
  result.centroid = getMat(params, "centroid")
  result.output = getMat(params, "output")
