import ../core

{.compile: "pca_wrapper.cpp".}
{.emit: "void mlpack_pca(mlpack::util::Params&, mlpack::util::Timers&);".}
proc mlpack_pca(params: var Params, timers: var Timers) {.importcpp: "mlpack_pca(@)".}

proc pca*(
    decomposition_method: string = "exact", # Method used for the principal components analysis: 'exact', 'randomized', 'randomized-block-krylov', 'quic'.
    input: Mat, # Input dataset to perform PCA on.
    new_dimensionality: int = 0, # Desired dimensionality of output dataset. If 0, no dimensionality reduction is performed.
    scale: bool = false, # If set, the data will be scaled before running PCA, such that the variance of each feature is 1.
    var_to_retain: float64 = 0, # Amount of variance to retain; should be between 0 and 1.  If 1, all variance is retained.  Overrides -d.
): Mat =
  var params = newParams("pca")
  var timers = newTimers()
  setCppString(params, "decomposition_method", toCppString(decomposition_method))
  setPassed(params, "decomposition_method")
  setMat(params, "input", input)
  setPassed(params, "input")
  setInt(params, "new_dimensionality", new_dimensionality)
  setPassed(params, "new_dimensionality")
  setBool(params, "scale", scale)
  setPassed(params, "scale")
  setDouble(params, "var_to_retain", var_to_retain)
  setPassed(params, "var_to_retain")
  setPassed(params, "output")
  mlpack_pca(params, timers)
  result = getMat(params, "output")
