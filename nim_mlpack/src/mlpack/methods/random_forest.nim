import ../core

{.compile: "random_forest_wrapper.cpp".}
{.emit: "void mlpack_random_forest(mlpack::util::Params&, mlpack::util::Timers&);".}
proc mlpack_random_forest(params: var Params, timers: var Timers) {.importcpp: "mlpack_random_forest(@)".}

type RandomForestModel* {.importc: "RandomForestModel".} = object
proc getRandomForestModel*(p: var Params, name: cstring): var RandomForestModel {.importcpp: "#.Get<RandomForestModel>(std::string(#))".}
proc setRandomForestModel*(p: var Params, name: cstring, val: RandomForestModel) {.importcpp: "#.Get<RandomForestModel>(std::string(#)) = #".}
proc newRandomForestModel*(): RandomForestModel {.importcpp: "RandomForestModel()".}

type arma::Row_size_t_* {.importc: "arma::Row<size_t>".} = object
proc getarma::Row_size_t_*(p: var Params, name: cstring): var arma::Row_size_t_ {.importcpp: "#.Get<arma::Row<size_t>>(std::string(#))".}
proc setarma::Row_size_t_*(p: var Params, name: cstring, val: arma::Row_size_t_) {.importcpp: "#.Get<arma::Row<size_t>>(std::string(#)) = #".}
proc newarma::Row_size_t_*(): arma::Row_size_t_ {.importcpp: "arma::Row<size_t>()".}

proc random_forest*(
    input_model: RandomForestModel = newRandomForestModel(), # Pre-trained random forest to use for classification.
    labels: arma::Row_size_t_ = newarma::Row_size_t_(), # Labels for training dataset.
    maximum_depth: int = 0, # Maximum depth of the tree (0 means no limit).
    minimum_gain_split: float64 = 0, # Minimum gain needed to make a split when building a tree.
    minimum_leaf_size: int = 1, # Minimum number of points in each leaf node.
    num_trees: int = 10, # Number of trees in the random forest.
    print_training_accuracy: bool = false, # If set, then the accuracy of the model on the training set will be predicted (verbose must also be specified).
    seed: int = 0, # Random seed.  If 0, 'std::time(NULL)' is used.
    subspace_dim: int = 0, # Dimensionality of random subspace to use for each split.  '0' will autoselect the square root of data dimensionality.
    test: Mat = newMat(), # Test dataset to produce predictions for.
    test_labels: arma::Row_size_t_ = newarma::Row_size_t_(), # Test dataset labels, if accuracy calculation is desired.
    training: Mat = newMat(), # Training dataset.
    warm_start: bool = false, # If true and passed along with `training` and `input_model` then trains more trees on top of existing model.
): tuple[output_model: RandomForestModel, predictions: arma::Row_size_t_, probabilities: Mat] =
  var params = newParams("random_forest")
  var timers = newTimers()
  setRandomForestModel(params, "input_model", input_model)
  setPassed(params, "input_model")
  setarma::Row_size_t_(params, "labels", labels)
  setPassed(params, "labels")
  setInt(params, "maximum_depth", maximum_depth)
  setPassed(params, "maximum_depth")
  setDouble(params, "minimum_gain_split", minimum_gain_split)
  setPassed(params, "minimum_gain_split")
  setInt(params, "minimum_leaf_size", minimum_leaf_size)
  setPassed(params, "minimum_leaf_size")
  setInt(params, "num_trees", num_trees)
  setPassed(params, "num_trees")
  setBool(params, "print_training_accuracy", print_training_accuracy)
  setPassed(params, "print_training_accuracy")
  setInt(params, "seed", seed)
  setPassed(params, "seed")
  setInt(params, "subspace_dim", subspace_dim)
  setPassed(params, "subspace_dim")
  setMat(params, "test", test)
  setPassed(params, "test")
  setarma::Row_size_t_(params, "test_labels", test_labels)
  setPassed(params, "test_labels")
  setMat(params, "training", training)
  setPassed(params, "training")
  setBool(params, "warm_start", warm_start)
  setPassed(params, "warm_start")
  setPassed(params, "output_model")
  setPassed(params, "predictions")
  setPassed(params, "probabilities")
  mlpack_random_forest(params, timers)
  result.output_model = getRandomForestModel(params, "output_model")
  result.predictions = getarma::Row_size_t_(params, "predictions")
  result.probabilities = getMat(params, "probabilities")
