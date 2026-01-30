import ../core

{.compile: "bayesian_linear_regression_wrapper.cpp".}
{.emit: "void mlpack_bayesian_linear_regression(mlpack::util::Params&, mlpack::util::Timers&);".}
proc mlpack_bayesian_linear_regression(params: var Params, timers: var Timers) {.importcpp: "mlpack_bayesian_linear_regression(@)".}

proc bayesian_linear_regression*(
    center: bool = false, # Center the data and fit the intercept if enabled.
    input: Mat = newMat(), # Matrix of covariates (X).
    input_model: Mat = newMat(), # Trained BayesianLinearRegression model to use.
    responses: Row = newRow(), # Matrix of responses/observations (y).
    scale: bool = false, # Scale each feature by their standard deviations if enabled.
    test: Mat = newMat(), # Matrix containing points to regress on (test points).
): tuple[output_model: Mat, predictions: Mat, stds: Mat] =
  var params = newParams("bayesian_linear_regression")
  var timers = newTimers()
  setBool(params, "center", center)
  setPassed(params, "center")
  setMat(params, "input", input)
  setPassed(params, "input")
  setMat(params, "input_model", input_model)
  setPassed(params, "input_model")
  setRow(params, "responses", responses)
  setPassed(params, "responses")
  setBool(params, "scale", scale)
  setPassed(params, "scale")
  setMat(params, "test", test)
  setPassed(params, "test")
  setPassed(params, "output_model")
  setPassed(params, "predictions")
  setPassed(params, "stds")
  mlpack_bayesian_linear_regression(params, timers)
  result.output_model = getMat(params, "output_model")
  result.predictions = getMat(params, "predictions")
  result.stds = getMat(params, "stds")
