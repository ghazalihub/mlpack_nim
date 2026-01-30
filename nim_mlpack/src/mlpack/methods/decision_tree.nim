import ../core

{.compile: "decision_tree_wrapper.cpp".}
{.emit: "void mlpack_decision_tree(mlpack::util::Params&, mlpack::util::Timers&);".}
proc mlpack_decision_tree(params: var Params, timers: var Timers) {.importcpp: "mlpack_decision_tree(@)".}

type DecisionTreeModel* {.importc: "DecisionTreeModel".} = object
proc getDecisionTreeModel*(p: var Params, name: cstring): var DecisionTreeModel {.importcpp: "#.Get<DecisionTreeModel>(std::string(#))".}
proc setDecisionTreeModel*(p: var Params, name: cstring, val: DecisionTreeModel) {.importcpp: "#.Get<DecisionTreeModel>(std::string(#)) = #".}
proc newDecisionTreeModel*(): DecisionTreeModel {.importcpp: "DecisionTreeModel()".}

type arma::Row_size_t_* {.importc: "arma::Row<size_t>".} = object
proc getarma::Row_size_t_*(p: var Params, name: cstring): var arma::Row_size_t_ {.importcpp: "#.Get<arma::Row<size_t>>(std::string(#))".}
proc setarma::Row_size_t_*(p: var Params, name: cstring, val: arma::Row_size_t_) {.importcpp: "#.Get<arma::Row<size_t>>(std::string(#)) = #".}
proc newarma::Row_size_t_*(): arma::Row_size_t_ {.importcpp: "arma::Row<size_t>()".}

proc decision_tree*(
    input_model: DecisionTreeModel = newDecisionTreeModel(), # Pre-trained decision tree, to be used with test points.
    labels: arma::Row_size_t_ = newarma::Row_size_t_(), # Training labels.
    maximum_depth: int = 0, # Maximum depth of the tree (0 means no limit).
    minimum_gain_split: float64 = 1e-07, # Minimum gain for node splitting.
    minimum_leaf_size: int = 20, # Minimum number of points in a leaf.
    print_training_accuracy: bool = false, # Print the training accuracy.
    test: string = "0x0 matrix with dimension type information", # Testing dataset (may be categorical).
    test_labels: arma::Row_size_t_ = newarma::Row_size_t_(), # Test point labels, if accuracy calculation is desired.
    training: string = "0x0 matrix with dimension type information", # Training dataset (may be categorical).
    weights: Mat = newMat(), # The weight of labels
): tuple[output_model: DecisionTreeModel, predictions: arma::Row_size_t_, probabilities: Mat] =
  var params = newParams("decision_tree")
  var timers = newTimers()
  setDecisionTreeModel(params, "input_model", input_model)
  setPassed(params, "input_model")
  setarma::Row_size_t_(params, "labels", labels)
  setPassed(params, "labels")
  setInt(params, "maximum_depth", maximum_depth)
  setPassed(params, "maximum_depth")
  setDouble(params, "minimum_gain_split", minimum_gain_split)
  setPassed(params, "minimum_gain_split")
  setInt(params, "minimum_leaf_size", minimum_leaf_size)
  setPassed(params, "minimum_leaf_size")
  setBool(params, "print_training_accuracy", print_training_accuracy)
  setPassed(params, "print_training_accuracy")
  setCppString(params, "test", toCppString(test))
  setPassed(params, "test")
  setarma::Row_size_t_(params, "test_labels", test_labels)
  setPassed(params, "test_labels")
  setCppString(params, "training", toCppString(training))
  setPassed(params, "training")
  setMat(params, "weights", weights)
  setPassed(params, "weights")
  setPassed(params, "output_model")
  setPassed(params, "predictions")
  setPassed(params, "probabilities")
  mlpack_decision_tree(params, timers)
  result.output_model = getDecisionTreeModel(params, "output_model")
  result.predictions = getarma::Row_size_t_(params, "predictions")
  result.probabilities = getMat(params, "probabilities")
