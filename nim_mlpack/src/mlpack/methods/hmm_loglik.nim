import ../core

{.compile: "hmm_loglik_wrapper.cpp".}
{.emit: "void mlpack_hmm_loglik(mlpack::util::Params&, mlpack::util::Timers&);".}
proc mlpack_hmm_loglik(params: var Params, timers: var Timers) {.importcpp: "mlpack_hmm_loglik(@)".}

type HMMModel* {.importc: "HMMModel".} = object
proc getHMMModel*(p: var Params, name: cstring): var HMMModel {.importcpp: "#.Get<HMMModel>(std::string(#))".}
proc setHMMModel*(p: var Params, name: cstring, val: HMMModel) {.importcpp: "#.Get<HMMModel>(std::string(#)) = #".}
proc newHMMModel*(): HMMModel {.importcpp: "HMMModel()".}

proc hmm_loglik*(
    input: Mat, # File containing observations,
    input_model: HMMModel, # File containing HMM.
): float64 =
  var params = newParams("hmm_loglik")
  var timers = newTimers()
  setMat(params, "input", input)
  setPassed(params, "input")
  setHMMModel(params, "input_model", input_model)
  setPassed(params, "input_model")
  setPassed(params, "log_likelihood")
  mlpack_hmm_loglik(params, timers)
  result = getDouble(params, "log_likelihood")
