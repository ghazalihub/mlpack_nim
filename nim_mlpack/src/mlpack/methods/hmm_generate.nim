import ../core

{.compile: "hmm_generate_wrapper.cpp".}
{.emit: "void mlpack_hmm_generate(mlpack::util::Params&, mlpack::util::Timers&);".}
proc mlpack_hmm_generate(params: var Params, timers: var Timers) {.importcpp: "mlpack_hmm_generate(@)".}

type HMMModel* {.importc: "HMMModel".} = object
proc getHMMModel*(p: var Params, name: cstring): var HMMModel {.importcpp: "#.Get<HMMModel>(std::string(#))".}
proc setHMMModel*(p: var Params, name: cstring, val: HMMModel) {.importcpp: "#.Get<HMMModel>(std::string(#)) = #".}
proc newHMMModel*(): HMMModel {.importcpp: "HMMModel()".}

proc hmm_generate*(
    length: int, # Length of sequence to generate.
    model: HMMModel, # Trained HMM to generate sequences with.
    seed: int = 0, # Random seed.  If 0, 'std::time(NULL)' is used.
    start_state: int = 0, # Starting state of sequence.
): tuple[output: Mat, state: UMat] =
  var params = newParams("hmm_generate")
  var timers = newTimers()
  setInt(params, "length", length)
  setPassed(params, "length")
  setHMMModel(params, "model", model)
  setPassed(params, "model")
  setInt(params, "seed", seed)
  setPassed(params, "seed")
  setInt(params, "start_state", start_state)
  setPassed(params, "start_state")
  setPassed(params, "output")
  setPassed(params, "state")
  mlpack_hmm_generate(params, timers)
  result.output = getMat(params, "output")
  result.state = getUMat(params, "state")
