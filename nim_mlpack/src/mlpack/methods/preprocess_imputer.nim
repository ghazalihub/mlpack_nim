import ../core

{.compile: "preprocess_imputer_wrapper.cpp".}
{.emit: "void mlpack_preprocess_imputer(mlpack::util::Params&, mlpack::util::Timers&);".}
proc mlpack_preprocess_imputer(params: var Params, timers: var Timers) {.importcpp: "mlpack_preprocess_imputer(@)".}

proc preprocess_imputer*(
    custom_value: float64 = 0, # User-defined custom imputation value; only used if the strategy is 'custom'.
    dimension: int = 0, # The dimension to apply imputation to.  If not specified, missing values will be imputed in every dimension.
    input: Mat = newMat(), # Input matrix to impute values for.
    missing_value: float64 = nan, # Value to use to indicate missing elements that will be imputed.
    strategy: string, # imputation strategy to be applied. Strategies should be one of 'custom', 'mean', 'median', and 'listwise_deletion'.
): Mat =
  var params = newParams("preprocess_imputer")
  var timers = newTimers()
  setDouble(params, "custom_value", custom_value)
  setPassed(params, "custom_value")
  setInt(params, "dimension", dimension)
  setPassed(params, "dimension")
  setMat(params, "input", input)
  setPassed(params, "input")
  setDouble(params, "missing_value", missing_value)
  setPassed(params, "missing_value")
  setCppString(params, "strategy", toCppString(strategy))
  setPassed(params, "strategy")
  setPassed(params, "output")
  mlpack_preprocess_imputer(params, timers)
  result = getMat(params, "output")
