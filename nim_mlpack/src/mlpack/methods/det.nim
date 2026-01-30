import ../core

{.compile: "det_wrapper.cpp".}
{.emit: "void mlpack_det(mlpack::util::Params&, mlpack::util::Timers&);".}
proc mlpack_det(params: var Params, timers: var Timers) {.importcpp: "mlpack_det(@)".}

proc det*(
    folds: int = 10, # The number of folds of cross-validation to perform for the estimation (0 is LOOCV)
    input_model: Mat = newMat(), # Trained density estimation tree to load.
    max_leaf_size: int = 10, # The maximum size of a leaf in the unpruned, fully grown DET.
    min_leaf_size: int = 5, # The minimum size of a leaf in the unpruned, fully grown DET.
    path_format: string = "lr", # The format of path printing: 'lr', 'id-lr', or 'lr-id'.
    skip_pruning: bool = false, # Whether to bypass the pruning process and output the unpruned tree only.
    test: Mat = newMat(), # A set of test points to estimate the density of.
    training: Mat = newMat(), # The data set on which to build a density estimation tree.
): tuple[output_model: Mat, tag_counters_file: string, tag_file: string, test_set_estimates: Mat, training_set_estimates: Mat, vi: Mat] =
  var params = newParams("det")
  var timers = newTimers()
  setInt(params, "folds", folds)
  setPassed(params, "folds")
  setMat(params, "input_model", input_model)
  setPassed(params, "input_model")
  setInt(params, "max_leaf_size", max_leaf_size)
  setPassed(params, "max_leaf_size")
  setInt(params, "min_leaf_size", min_leaf_size)
  setPassed(params, "min_leaf_size")
  setCppString(params, "path_format", toCppString(path_format))
  setPassed(params, "path_format")
  setBool(params, "skip_pruning", skip_pruning)
  setPassed(params, "skip_pruning")
  setMat(params, "test", test)
  setPassed(params, "test")
  setMat(params, "training", training)
  setPassed(params, "training")
  setPassed(params, "output_model")
  setPassed(params, "tag_counters_file")
  setPassed(params, "tag_file")
  setPassed(params, "test_set_estimates")
  setPassed(params, "training_set_estimates")
  setPassed(params, "vi")
  mlpack_det(params, timers)
  result.output_model = getMat(params, "output_model")
  result.tag_counters_file = $(getCppString(params, "tag_counters_file"))
  result.tag_file = $(getCppString(params, "tag_file"))
  result.test_set_estimates = getMat(params, "test_set_estimates")
  result.training_set_estimates = getMat(params, "training_set_estimates")
  result.vi = getMat(params, "vi")
