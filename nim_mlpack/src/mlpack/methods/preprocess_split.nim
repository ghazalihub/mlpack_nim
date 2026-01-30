import ../core

{.compile: "preprocess_split_wrapper.cpp".}
{.emit: "void mlpack_preprocess_split(mlpack::util::Params&, mlpack::util::Timers&);".}
proc mlpack_preprocess_split(params: var Params, timers: var Timers) {.importcpp: "mlpack_preprocess_split(@)".}

proc preprocess_split*(
    input: Mat, # Matrix containing data.
    input_labels: UMat = newUMat(), # Matrix containing labels.
    no_shuffle: bool = false, # Avoid shuffling the data before splitting.
    seed: int = 0, # Random seed (0 for std::time(NULL)).
    stratify_data: bool = false, # Stratify the data according to labels
    test_ratio: float64 = 0.2, # Ratio of test set; if not set,the ratio defaults to 0.2
): tuple[test: Mat, test_labels: UMat, training: Mat, training_labels: UMat] =
  var params = newParams("preprocess_split")
  var timers = newTimers()
  setMat(params, "input", input)
  setPassed(params, "input")
  setUMat(params, "input_labels", input_labels)
  setPassed(params, "input_labels")
  setBool(params, "no_shuffle", no_shuffle)
  setPassed(params, "no_shuffle")
  setInt(params, "seed", seed)
  setPassed(params, "seed")
  setBool(params, "stratify_data", stratify_data)
  setPassed(params, "stratify_data")
  setDouble(params, "test_ratio", test_ratio)
  setPassed(params, "test_ratio")
  setPassed(params, "test")
  setPassed(params, "test_labels")
  setPassed(params, "training")
  setPassed(params, "training_labels")
  mlpack_preprocess_split(params, timers)
  result.test = getMat(params, "test")
  result.test_labels = getUMat(params, "test_labels")
  result.training = getMat(params, "training")
  result.training_labels = getUMat(params, "training_labels")
