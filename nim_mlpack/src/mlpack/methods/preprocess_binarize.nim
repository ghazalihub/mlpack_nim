import ../core

{.compile: "preprocess_binarize_wrapper.cpp".}
{.emit: "void mlpack_preprocess_binarize(mlpack::util::Params&, mlpack::util::Timers&);".}
proc mlpack_preprocess_binarize(params: var Params, timers: var Timers) {.importcpp: "mlpack_preprocess_binarize(@)".}

proc preprocess_binarize*(
    dimension: int = 0, # Dimension to apply the binarization. If not set, the program will binarize every dimension by default.
    input: Mat, # Input data matrix.
    threshold: float64 = 0, # Threshold to be applied for binarization. If not set, the threshold defaults to 0.0.
): Mat =
  var params = newParams("preprocess_binarize")
  var timers = newTimers()
  setInt(params, "dimension", dimension)
  setPassed(params, "dimension")
  setMat(params, "input", input)
  setPassed(params, "input")
  setDouble(params, "threshold", threshold)
  setPassed(params, "threshold")
  setPassed(params, "output")
  mlpack_preprocess_binarize(params, timers)
  result = getMat(params, "output")
