import ../core

{.compile: "perceptron_wrapper.cpp".}
{.emit: "void mlpack_perceptron(mlpack::util::Params&, mlpack::util::Timers&);".}
proc mlpack_perceptron(params: var Params, timers: var Timers) {.importcpp: "mlpack_perceptron(@)".}

type PerceptronModel* {.importc: "PerceptronModel".} = object
proc getPerceptronModel*(p: var Params, name: cstring): var PerceptronModel {.importcpp: "#.Get<PerceptronModel>(std::string(#))".}
proc setPerceptronModel*(p: var Params, name: cstring, val: PerceptronModel) {.importcpp: "#.Get<PerceptronModel>(std::string(#)) = #".}
proc newPerceptronModel*(): PerceptronModel {.importcpp: "PerceptronModel()".}

type arma::Row_size_t_* {.importc: "arma::Row<size_t>".} = object
proc getarma::Row_size_t_*(p: var Params, name: cstring): var arma::Row_size_t_ {.importcpp: "#.Get<arma::Row<size_t>>(std::string(#))".}
proc setarma::Row_size_t_*(p: var Params, name: cstring, val: arma::Row_size_t_) {.importcpp: "#.Get<arma::Row<size_t>>(std::string(#)) = #".}
proc newarma::Row_size_t_*(): arma::Row_size_t_ {.importcpp: "arma::Row<size_t>()".}

proc perceptron*(
    input_model: PerceptronModel = newPerceptronModel(), # Input perceptron model.
    labels: arma::Row_size_t_ = newarma::Row_size_t_(), # A matrix containing labels for the training set.
    max_iterations: int = 1000, # The maximum number of iterations the perceptron is to be run
    test: Mat = newMat(), # A matrix containing the test set.
    training: Mat = newMat(), # A matrix containing the training set.
): tuple[output_model: PerceptronModel, predictions: arma::Row_size_t_] =
  var params = newParams("perceptron")
  var timers = newTimers()
  setPerceptronModel(params, "input_model", input_model)
  setPassed(params, "input_model")
  setarma::Row_size_t_(params, "labels", labels)
  setPassed(params, "labels")
  setInt(params, "max_iterations", max_iterations)
  setPassed(params, "max_iterations")
  setMat(params, "test", test)
  setPassed(params, "test")
  setMat(params, "training", training)
  setPassed(params, "training")
  setPassed(params, "output_model")
  setPassed(params, "predictions")
  mlpack_perceptron(params, timers)
  result.output_model = getPerceptronModel(params, "output_model")
  result.predictions = getarma::Row_size_t_(params, "predictions")
