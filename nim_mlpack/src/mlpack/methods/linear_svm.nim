import ../core

{.compile: "linear_svm_wrapper.cpp".}
{.emit: "void mlpack_linear_svm(mlpack::util::Params&, mlpack::util::Timers&);".}
proc mlpack_linear_svm(params: var Params, timers: var Timers) {.importcpp: "mlpack_linear_svm(@)".}

type LinearSVMModel* {.importc: "LinearSVMModel".} = object
proc getLinearSVMModel*(p: var Params, name: cstring): var LinearSVMModel {.importcpp: "#.Get<LinearSVMModel>(std::string(#))".}
proc setLinearSVMModel*(p: var Params, name: cstring, val: LinearSVMModel) {.importcpp: "#.Get<LinearSVMModel>(std::string(#)) = #".}
proc newLinearSVMModel*(): LinearSVMModel {.importcpp: "LinearSVMModel()".}

type arma::Row_size_t_* {.importc: "arma::Row<size_t>".} = object
proc getarma::Row_size_t_*(p: var Params, name: cstring): var arma::Row_size_t_ {.importcpp: "#.Get<arma::Row<size_t>>(std::string(#))".}
proc setarma::Row_size_t_*(p: var Params, name: cstring, val: arma::Row_size_t_) {.importcpp: "#.Get<arma::Row<size_t>>(std::string(#)) = #".}
proc newarma::Row_size_t_*(): arma::Row_size_t_ {.importcpp: "arma::Row<size_t>()".}

proc linear_svm*(
    delta: float64 = 1, # Margin of difference between correct class and other classes.
    epochs: int = 50, # Maximum number of full epochs over dataset for psgd
    input_model: LinearSVMModel = newLinearSVMModel(), # Existing model (parameters).
    labels: arma::Row_size_t_ = newarma::Row_size_t_(), # A matrix containing labels (0 or 1) for the points in the training set (y).
    lambda: float64 = 0.0001, # L2-regularization parameter for training.
    max_iterations: int = 10000, # Maximum iterations for optimizer (0 indicates no limit).
    no_intercept: bool = false, # Do not add the intercept term to the model.
    num_classes: int = 0, # Number of classes for classification; if unspecified (or 0), the number of classes found in the labels will be used.
    optimizer: string = "lbfgs", # Optimizer to use for training ('lbfgs' or 'psgd').
    seed: int = 0, # Random seed.  If 0, 'std::time(NULL)' is used.
    shuffle: bool = false, # Don't shuffle the order in which data points are visited for parallel SGD.
    step_size: float64 = 0.01, # Step size for parallel SGD optimizer.
    test: Mat = newMat(), # Matrix containing test dataset.
    test_labels: arma::Row_size_t_ = newarma::Row_size_t_(), # Matrix containing test labels.
    tolerance: float64 = 1e-10, # Convergence tolerance for optimizer.
    training: Mat = newMat(), # A matrix containing the training set (the matrix of predictors, X).
): tuple[output_model: LinearSVMModel, predictions: arma::Row_size_t_, probabilities: Mat] =
  var params = newParams("linear_svm")
  var timers = newTimers()
  setDouble(params, "delta", delta)
  setPassed(params, "delta")
  setInt(params, "epochs", epochs)
  setPassed(params, "epochs")
  setLinearSVMModel(params, "input_model", input_model)
  setPassed(params, "input_model")
  setarma::Row_size_t_(params, "labels", labels)
  setPassed(params, "labels")
  setDouble(params, "lambda", lambda)
  setPassed(params, "lambda")
  setInt(params, "max_iterations", max_iterations)
  setPassed(params, "max_iterations")
  setBool(params, "no_intercept", no_intercept)
  setPassed(params, "no_intercept")
  setInt(params, "num_classes", num_classes)
  setPassed(params, "num_classes")
  setCppString(params, "optimizer", toCppString(optimizer))
  setPassed(params, "optimizer")
  setInt(params, "seed", seed)
  setPassed(params, "seed")
  setBool(params, "shuffle", shuffle)
  setPassed(params, "shuffle")
  setDouble(params, "step_size", step_size)
  setPassed(params, "step_size")
  setMat(params, "test", test)
  setPassed(params, "test")
  setarma::Row_size_t_(params, "test_labels", test_labels)
  setPassed(params, "test_labels")
  setDouble(params, "tolerance", tolerance)
  setPassed(params, "tolerance")
  setMat(params, "training", training)
  setPassed(params, "training")
  setPassed(params, "output_model")
  setPassed(params, "predictions")
  setPassed(params, "probabilities")
  mlpack_linear_svm(params, timers)
  result.output_model = getLinearSVMModel(params, "output_model")
  result.predictions = getarma::Row_size_t_(params, "predictions")
  result.probabilities = getMat(params, "probabilities")
