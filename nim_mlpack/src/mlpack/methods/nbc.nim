import ../core

{.compile: "nbc_wrapper.cpp".}
{.emit: "void mlpack_nbc(mlpack::util::Params&, mlpack::util::Timers&);".}
proc mlpack_nbc(params: var Params, timers: var Timers) {.importcpp: "mlpack_nbc(@)".}

type NBCModel* {.importc: "NBCModel".} = object
proc getNBCModel*(p: var Params, name: cstring): var NBCModel {.importcpp: "#.Get<NBCModel>(std::string(#))".}
proc setNBCModel*(p: var Params, name: cstring, val: NBCModel) {.importcpp: "#.Get<NBCModel>(std::string(#)) = #".}
proc newNBCModel*(): NBCModel {.importcpp: "NBCModel()".}

type arma::Row_size_t_* {.importc: "arma::Row<size_t>".} = object
proc getarma::Row_size_t_*(p: var Params, name: cstring): var arma::Row_size_t_ {.importcpp: "#.Get<arma::Row<size_t>>(std::string(#))".}
proc setarma::Row_size_t_*(p: var Params, name: cstring, val: arma::Row_size_t_) {.importcpp: "#.Get<arma::Row<size_t>>(std::string(#)) = #".}
proc newarma::Row_size_t_*(): arma::Row_size_t_ {.importcpp: "arma::Row<size_t>()".}

proc nbc*(
    incremental_variance: bool = false, # The variance of each class will be calculated incrementally.
    input_model: NBCModel = newNBCModel(), # Input Naive Bayes model.
    labels: arma::Row_size_t_ = newarma::Row_size_t_(), # A file containing labels for the training set.
    test: Mat = newMat(), # A matrix containing the test set.
    training: Mat = newMat(), # A matrix containing the training set.
): tuple[output_model: NBCModel, predictions: arma::Row_size_t_, probabilities: Mat] =
  var params = newParams("nbc")
  var timers = newTimers()
  setBool(params, "incremental_variance", incremental_variance)
  setPassed(params, "incremental_variance")
  setNBCModel(params, "input_model", input_model)
  setPassed(params, "input_model")
  setarma::Row_size_t_(params, "labels", labels)
  setPassed(params, "labels")
  setMat(params, "test", test)
  setPassed(params, "test")
  setMat(params, "training", training)
  setPassed(params, "training")
  setPassed(params, "output_model")
  setPassed(params, "predictions")
  setPassed(params, "probabilities")
  mlpack_nbc(params, timers)
  result.output_model = getNBCModel(params, "output_model")
  result.predictions = getarma::Row_size_t_(params, "predictions")
  result.probabilities = getMat(params, "probabilities")
