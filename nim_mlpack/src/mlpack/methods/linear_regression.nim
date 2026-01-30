import ../core

{.compile: "linear_regression_wrapper.cpp".}
{.emit: "void mlpack_linear_regression(mlpack::util::Params&, mlpack::util::Timers&);".}
proc mlpack_linear_regression(params: var Params, timers: var Timers) {.importcpp: "mlpack_linear_regression(@)".}

proc linear_regression*(
    input_model: Mat = newMat(), # Existing LinearRegression model to use.
    lambda: float64 = 0, # Tikhonov regularization for ridge regression.  If 0, the method reduces to linear regression.
    test: Mat = newMat(), # Matrix containing X' (test regressors).
    training: Mat = newMat(), # Matrix containing training set X (regressors).
    training_responses: Row = newRow(), # Optional vector containing y (responses). If not given, the responses are assumed to be the last row of the input file.
): tuple[output_model: Mat, output_predictions: Row] =
  var params = newParams("linear_regression")
  var timers = newTimers()
  setMat(params, "input_model", input_model)
  setPassed(params, "input_model")
  setDouble(params, "lambda", lambda)
  setPassed(params, "lambda")
  setMat(params, "test", test)
  setPassed(params, "test")
  setMat(params, "training", training)
  setPassed(params, "training")
  setRow(params, "training_responses", training_responses)
  setPassed(params, "training_responses")
  setPassed(params, "output_model")
  setPassed(params, "output_predictions")
  mlpack_linear_regression(params, timers)
  result.output_model = getMat(params, "output_model")
  result.output_predictions = getRow(params, "output_predictions")
