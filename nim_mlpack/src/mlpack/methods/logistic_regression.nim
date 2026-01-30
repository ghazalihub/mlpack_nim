import ../core

{.compile: "logistic_regression_wrapper.cpp".}
{.emit: "void mlpack_logistic_regression(mlpack::util::Params&, mlpack::util::Timers&);".}
proc mlpack_logistic_regression(params: var Params, timers: var Timers) {.importcpp: "mlpack_logistic_regression(@)".}

type arma::Row_size_t_* {.importc: "arma::Row<size_t>".} = object
proc getarma::Row_size_t_*(p: var Params, name: cstring): var arma::Row_size_t_ {.importcpp: "#.Get<arma::Row<size_t>>(std::string(#))".}
proc setarma::Row_size_t_*(p: var Params, name: cstring, val: arma::Row_size_t_) {.importcpp: "#.Get<arma::Row<size_t>>(std::string(#)) = #".}
proc newarma::Row_size_t_*(): arma::Row_size_t_ {.importcpp: "arma::Row<size_t>()".}

proc logistic_regression*(
    batch_size: int = 64, # Batch size for SGD.
    decision_boundary: float64 = 0.5, # Decision boundary for prediction; if the logistic function for a point is less than the boundary, the class is taken to be 0; otherwise, the class is 1.
    input_model: Mat = newMat(), # Existing model (parameters).
    labels: arma::Row_size_t_ = newarma::Row_size_t_(), # A matrix containing labels (0 or 1) for the points in the training set (y).
    lambda: float64 = 0, # L2-regularization parameter for training.
    max_iterations: int = 10000, # Maximum iterations for optimizer (0 indicates no limit).
    optimizer: string = "lbfgs", # Optimizer to use for training ('lbfgs' or 'sgd').
    print_training_accuracy: bool = false, # If set, then the accuracy of the model on the training set will be printed (verbose must also be specified).
    step_size: float64 = 0.01, # Step size for SGD optimizer.
    test: Mat = newMat(), # Matrix containing test dataset.
    tolerance: float64 = 1e-10, # Convergence tolerance for optimizer.
    training: Mat = newMat(), # A matrix containing the training set (the matrix of predictors, X).
): tuple[output_model: Mat, predictions: arma::Row_size_t_, probabilities: Mat] =
  var params = newParams("logistic_regression")
  var timers = newTimers()
  setInt(params, "batch_size", batch_size)
  setPassed(params, "batch_size")
  setDouble(params, "decision_boundary", decision_boundary)
  setPassed(params, "decision_boundary")
  setMat(params, "input_model", input_model)
  setPassed(params, "input_model")
  setarma::Row_size_t_(params, "labels", labels)
  setPassed(params, "labels")
  setDouble(params, "lambda", lambda)
  setPassed(params, "lambda")
  setInt(params, "max_iterations", max_iterations)
  setPassed(params, "max_iterations")
  setCppString(params, "optimizer", toCppString(optimizer))
  setPassed(params, "optimizer")
  setBool(params, "print_training_accuracy", print_training_accuracy)
  setPassed(params, "print_training_accuracy")
  setDouble(params, "step_size", step_size)
  setPassed(params, "step_size")
  setMat(params, "test", test)
  setPassed(params, "test")
  setDouble(params, "tolerance", tolerance)
  setPassed(params, "tolerance")
  setMat(params, "training", training)
  setPassed(params, "training")
  setPassed(params, "output_model")
  setPassed(params, "predictions")
  setPassed(params, "probabilities")
  mlpack_logistic_regression(params, timers)
  result.output_model = getMat(params, "output_model")
  result.predictions = getarma::Row_size_t_(params, "predictions")
  result.probabilities = getMat(params, "probabilities")
