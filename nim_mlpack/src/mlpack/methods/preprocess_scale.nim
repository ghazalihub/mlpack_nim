import ../core

{.compile: "preprocess_scale_wrapper.cpp".}
{.emit: "void mlpack_preprocess_scale(mlpack::util::Params&, mlpack::util::Timers&);".}
proc mlpack_preprocess_scale(params: var Params, timers: var Timers) {.importcpp: "mlpack_preprocess_scale(@)".}

type ScalingModel* {.importc: "ScalingModel".} = object
proc getScalingModel*(p: var Params, name: cstring): var ScalingModel {.importcpp: "#.Get<ScalingModel>(std::string(#))".}
proc setScalingModel*(p: var Params, name: cstring, val: ScalingModel) {.importcpp: "#.Get<ScalingModel>(std::string(#)) = #".}
proc newScalingModel*(): ScalingModel {.importcpp: "ScalingModel()".}

proc preprocess_scale*(
    epsilon: float64 = 1e-06, # regularization Parameter for pcawhitening, or zcawhitening, should be between -1 to 1.
    input: Mat, # Matrix containing data.
    input_model: ScalingModel = newScalingModel(), # Input Scaling model.
    inverse_scaling: bool = false, # Inverse Scaling to get original dataset
    max_value: int = 1, # Ending value of range for min_max_scaler.
    min_value: int = 0, # Starting value of range for min_max_scaler.
    scaler_method: string = "standard_scaler", # method to use for scaling, the default is standard_scaler.
    seed: int = 0, # Random seed (0 for std::time(NULL)).
): tuple[output: Mat, output_model: ScalingModel] =
  var params = newParams("preprocess_scale")
  var timers = newTimers()
  setDouble(params, "epsilon", epsilon)
  setPassed(params, "epsilon")
  setMat(params, "input", input)
  setPassed(params, "input")
  setScalingModel(params, "input_model", input_model)
  setPassed(params, "input_model")
  setBool(params, "inverse_scaling", inverse_scaling)
  setPassed(params, "inverse_scaling")
  setInt(params, "max_value", max_value)
  setPassed(params, "max_value")
  setInt(params, "min_value", min_value)
  setPassed(params, "min_value")
  setCppString(params, "scaler_method", toCppString(scaler_method))
  setPassed(params, "scaler_method")
  setInt(params, "seed", seed)
  setPassed(params, "seed")
  setPassed(params, "output")
  setPassed(params, "output_model")
  mlpack_preprocess_scale(params, timers)
  result.output = getMat(params, "output")
  result.output_model = getScalingModel(params, "output_model")
