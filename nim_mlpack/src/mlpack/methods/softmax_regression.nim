import ../core

{.compile: "softmax_regression_wrapper.cpp".}
{.emit: "void mlpack_softmax_regression(mlpack::util::Params&, mlpack::util::Timers&);".}
proc mlpack_softmax_regression(params: var Params, timers: var Timers) {.importcpp: "mlpack_softmax_regression(@)".}

type arma::Row_size_t_* {.importc: "arma::Row<size_t>".} = object
proc getarma::Row_size_t_*(p: var Params, name: cstring): var arma::Row_size_t_ {.importcpp: "#.Get<arma::Row<size_t>>(std::string(#))".}
proc setarma::Row_size_t_*(p: var Params, name: cstring, val: arma::Row_size_t_) {.importcpp: "#.Get<arma::Row<size_t>>(std::string(#)) = #".}
proc newarma::Row_size_t_*(): arma::Row_size_t_ {.importcpp: "arma::Row<size_t>()".}

proc softmax_regression*(
    input_model: Mat = newMat(), # File containing existing model (parameters).
    labels: arma::Row_size_t_ = newarma::Row_size_t_(), # A matrix containing labels (0 or 1) for the points in the training set (y). The labels must order as a row.
    lambda: float64 = 0.0001, # L2-regularization constant
    max_iterations: int = 400, # Maximum number of iterations before termination.
    no_intercept: bool = false, # Do not add the intercept term to the model.
    number_of_classes: int = 0, # Number of classes for classification; if unspecified (or 0), the number of classes found in the labels will be used.
    test: Mat = newMat(), # Matrix containing test dataset.
    test_labels: arma::Row_size_t_ = newarma::Row_size_t_(), # Matrix containing test labels.
    training: Mat = newMat(), # A matrix containing the training set (the matrix of predictors, X).
): tuple[output_model: Mat, predictions: arma::Row_size_t_, probabilities: Mat] =
  var params = newParams("softmax_regression")
  var timers = newTimers()
  setMat(params, "input_model", input_model)
  setPassed(params, "input_model")
  setarma::Row_size_t_(params, "labels", labels)
  setPassed(params, "labels")
  setDouble(params, "lambda", lambda)
  setPassed(params, "lambda")
  setInt(params, "max_iterations", max_iterations)
  setPassed(params, "max_iterations")
  setBool(params, "no_intercept", no_intercept)
  setPassed(params, "no_intercept")
  setInt(params, "number_of_classes", number_of_classes)
  setPassed(params, "number_of_classes")
  setMat(params, "test", test)
  setPassed(params, "test")
  setarma::Row_size_t_(params, "test_labels", test_labels)
  setPassed(params, "test_labels")
  setMat(params, "training", training)
  setPassed(params, "training")
  setPassed(params, "output_model")
  setPassed(params, "predictions")
  setPassed(params, "probabilities")
  mlpack_softmax_regression(params, timers)
  result.output_model = getMat(params, "output_model")
  result.predictions = getarma::Row_size_t_(params, "predictions")
  result.probabilities = getMat(params, "probabilities")
