import ../core

{.compile: "hmm_viterbi_wrapper.cpp".}
{.emit: "void mlpack_hmm_viterbi(mlpack::util::Params&, mlpack::util::Timers&);".}
proc mlpack_hmm_viterbi(params: var Params, timers: var Timers) {.importcpp: "mlpack_hmm_viterbi(@)".}

type HMMModel* {.importc: "HMMModel".} = object
proc getHMMModel*(p: var Params, name: cstring): var HMMModel {.importcpp: "#.Get<HMMModel>(std::string(#))".}
proc setHMMModel*(p: var Params, name: cstring, val: HMMModel) {.importcpp: "#.Get<HMMModel>(std::string(#)) = #".}
proc newHMMModel*(): HMMModel {.importcpp: "HMMModel()".}

proc hmm_viterbi*(
    input: Mat, # Matrix containing observations,
    input_model: HMMModel, # Trained HMM to use.
): UMat =
  var params = newParams("hmm_viterbi")
  var timers = newTimers()
  setMat(params, "input", input)
  setPassed(params, "input")
  setHMMModel(params, "input_model", input_model)
  setPassed(params, "input_model")
  setPassed(params, "output")
  mlpack_hmm_viterbi(params, timers)
  result = getUMat(params, "output")
