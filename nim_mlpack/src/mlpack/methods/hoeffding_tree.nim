import ../core

{.compile: "hoeffding_tree_wrapper.cpp".}
{.emit: "void mlpack_hoeffding_tree(mlpack::util::Params&, mlpack::util::Timers&);".}
proc mlpack_hoeffding_tree(params: var Params, timers: var Timers) {.importcpp: "mlpack_hoeffding_tree(@)".}

type HoeffdingTreeModel* {.importc: "HoeffdingTreeModel".} = object
proc getHoeffdingTreeModel*(p: var Params, name: cstring): var HoeffdingTreeModel {.importcpp: "#.Get<HoeffdingTreeModel>(std::string(#))".}
proc setHoeffdingTreeModel*(p: var Params, name: cstring, val: HoeffdingTreeModel) {.importcpp: "#.Get<HoeffdingTreeModel>(std::string(#)) = #".}
proc newHoeffdingTreeModel*(): HoeffdingTreeModel {.importcpp: "HoeffdingTreeModel()".}

type arma::Row_size_t_* {.importc: "arma::Row<size_t>".} = object
proc getarma::Row_size_t_*(p: var Params, name: cstring): var arma::Row_size_t_ {.importcpp: "#.Get<arma::Row<size_t>>(std::string(#))".}
proc setarma::Row_size_t_*(p: var Params, name: cstring, val: arma::Row_size_t_) {.importcpp: "#.Get<arma::Row<size_t>>(std::string(#)) = #".}
proc newarma::Row_size_t_*(): arma::Row_size_t_ {.importcpp: "arma::Row<size_t>()".}

proc hoeffding_tree*(
    batch_mode: bool = false, # If true, samples will be considered in batch instead of as a stream.  This generally results in better trees but at the cost of memory usage and runtime.
    bins: int = 10, # If the 'domingos' split strategy is used, this specifies the number of bins for each numeric split.
    confidence: float64 = 0.95, # Confidence before splitting (between 0 and 1).
    info_gain: bool = false, # If set, information gain is used instead of Gini impurity for calculating Hoeffding bounds.
    input_model: HoeffdingTreeModel = newHoeffdingTreeModel(), # Input trained Hoeffding tree model.
    labels: arma::Row_size_t_ = newarma::Row_size_t_(), # Labels for training dataset.
    max_samples: int = 5000, # Maximum number of samples before splitting.
    min_samples: int = 100, # Minimum number of samples before splitting.
    numeric_split_strategy: string = "binary", # The splitting strategy to use for numeric features: 'domingos' or 'binary'.
    observations_before_binning: int = 100, # If the 'domingos' split strategy is used, this specifies the number of samples observed before binning is performed.
    passes: int = 1, # Number of passes to take over the dataset.
    test: string = "0x0 matrix with dimension type information", # Testing dataset (may be categorical).
    test_labels: arma::Row_size_t_ = newarma::Row_size_t_(), # Labels of test data.
    training: string = "0x0 matrix with dimension type information", # Training dataset (may be categorical).
): tuple[output_model: HoeffdingTreeModel, predictions: arma::Row_size_t_, probabilities: Mat] =
  var params = newParams("hoeffding_tree")
  var timers = newTimers()
  setBool(params, "batch_mode", batch_mode)
  setPassed(params, "batch_mode")
  setInt(params, "bins", bins)
  setPassed(params, "bins")
  setDouble(params, "confidence", confidence)
  setPassed(params, "confidence")
  setBool(params, "info_gain", info_gain)
  setPassed(params, "info_gain")
  setHoeffdingTreeModel(params, "input_model", input_model)
  setPassed(params, "input_model")
  setarma::Row_size_t_(params, "labels", labels)
  setPassed(params, "labels")
  setInt(params, "max_samples", max_samples)
  setPassed(params, "max_samples")
  setInt(params, "min_samples", min_samples)
  setPassed(params, "min_samples")
  setCppString(params, "numeric_split_strategy", toCppString(numeric_split_strategy))
  setPassed(params, "numeric_split_strategy")
  setInt(params, "observations_before_binning", observations_before_binning)
  setPassed(params, "observations_before_binning")
  setInt(params, "passes", passes)
  setPassed(params, "passes")
  setCppString(params, "test", toCppString(test))
  setPassed(params, "test")
  setarma::Row_size_t_(params, "test_labels", test_labels)
  setPassed(params, "test_labels")
  setCppString(params, "training", toCppString(training))
  setPassed(params, "training")
  setPassed(params, "output_model")
  setPassed(params, "predictions")
  setPassed(params, "probabilities")
  mlpack_hoeffding_tree(params, timers)
  result.output_model = getHoeffdingTreeModel(params, "output_model")
  result.predictions = getarma::Row_size_t_(params, "predictions")
  result.probabilities = getMat(params, "probabilities")
