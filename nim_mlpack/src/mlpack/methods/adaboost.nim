import ../core

{.compile: "adaboost_wrapper.cpp".}
{.emit: "void mlpack_adaboost(mlpack::util::Params&, mlpack::util::Timers&);".}
proc mlpack_adaboost(params: var Params, timers: var Timers) {.importcpp: "mlpack_adaboost(@)".}

type AdaBoostModel* {.importc: "AdaBoostModel".} = object
proc getAdaBoostModel*(p: var Params, name: cstring): var AdaBoostModel {.importcpp: "#.Get<AdaBoostModel>(std::string(#))".}
proc setAdaBoostModel*(p: var Params, name: cstring, val: AdaBoostModel) {.importcpp: "#.Get<AdaBoostModel>(std::string(#)) = #".}
proc newAdaBoostModel*(): AdaBoostModel {.importcpp: "AdaBoostModel()".}

type arma::Row_size_t_* {.importc: "arma::Row<size_t>".} = object
proc getarma::Row_size_t_*(p: var Params, name: cstring): var arma::Row_size_t_ {.importcpp: "#.Get<arma::Row<size_t>>(std::string(#))".}
proc setarma::Row_size_t_*(p: var Params, name: cstring, val: arma::Row_size_t_) {.importcpp: "#.Get<arma::Row<size_t>>(std::string(#)) = #".}
proc newarma::Row_size_t_*(): arma::Row_size_t_ {.importcpp: "arma::Row<size_t>()".}

proc adaboost*(
    input_model: AdaBoostModel = newAdaBoostModel(), # Input AdaBoost model.
    iterations: int = 1000, # The maximum number of boosting iterations to be run (0 will run until convergence.)
    labels: arma::Row_size_t_ = newarma::Row_size_t_(), # Labels for the training set.
    test: Mat = newMat(), # Test dataset.
    tolerance: float64 = 1e-10, # The tolerance for change in values of the weighted error during training.
    training: Mat = newMat(), # Dataset for training AdaBoost.
    weak_learner: string = "decision_stump", # The type of weak learner to use: 'decision_stump', or 'perceptron'.
): tuple[output_model: AdaBoostModel, predictions: arma::Row_size_t_, probabilities: Mat] =
  var params = newParams("adaboost")
  var timers = newTimers()
  setAdaBoostModel(params, "input_model", input_model)
  setPassed(params, "input_model")
  setInt(params, "iterations", iterations)
  setPassed(params, "iterations")
  setarma::Row_size_t_(params, "labels", labels)
  setPassed(params, "labels")
  setMat(params, "test", test)
  setPassed(params, "test")
  setDouble(params, "tolerance", tolerance)
  setPassed(params, "tolerance")
  setMat(params, "training", training)
  setPassed(params, "training")
  setCppString(params, "weak_learner", toCppString(weak_learner))
  setPassed(params, "weak_learner")
  setPassed(params, "output_model")
  setPassed(params, "predictions")
  setPassed(params, "probabilities")
  mlpack_adaboost(params, timers)
  result.output_model = getAdaBoostModel(params, "output_model")
  result.predictions = getarma::Row_size_t_(params, "predictions")
  result.probabilities = getMat(params, "probabilities")
