import ../core

{.compile: "lars_wrapper.cpp".}
{.emit: "void mlpack_lars(mlpack::util::Params&, mlpack::util::Timers&);".}
proc mlpack_lars(params: var Params, timers: var Timers) {.importcpp: "mlpack_lars(@)".}

proc lars*(
    input: Mat = newMat(), # Matrix of covariates (X).
    input_model: Mat = newMat(), # Trained LARS model to use.
    lambda1: float64 = 0, # Regularization parameter for l1-norm penalty.
    lambda2: float64 = 0, # Regularization parameter for l2-norm penalty.
    no_intercept: bool = false, # Do not fit an intercept in the model.
    no_normalize: bool = false, # Do not normalize data to unit variance before modeling.
    responses: Mat = newMat(), # Matrix of responses/observations (y).
    test: Mat = newMat(), # Matrix containing points to regress on (test points).
    use_cholesky: bool = false, # Use Cholesky decomposition during computation rather than explicitly computing the full Gram matrix.
): tuple[output_model: Mat, output_predictions: Mat] =
  var params = newParams("lars")
  var timers = newTimers()
  setMat(params, "input", input)
  setPassed(params, "input")
  setMat(params, "input_model", input_model)
  setPassed(params, "input_model")
  setDouble(params, "lambda1", lambda1)
  setPassed(params, "lambda1")
  setDouble(params, "lambda2", lambda2)
  setPassed(params, "lambda2")
  setBool(params, "no_intercept", no_intercept)
  setPassed(params, "no_intercept")
  setBool(params, "no_normalize", no_normalize)
  setPassed(params, "no_normalize")
  setMat(params, "responses", responses)
  setPassed(params, "responses")
  setMat(params, "test", test)
  setPassed(params, "test")
  setBool(params, "use_cholesky", use_cholesky)
  setPassed(params, "use_cholesky")
  setPassed(params, "output_model")
  setPassed(params, "output_predictions")
  mlpack_lars(params, timers)
  result.output_model = getMat(params, "output_model")
  result.output_predictions = getMat(params, "output_predictions")
