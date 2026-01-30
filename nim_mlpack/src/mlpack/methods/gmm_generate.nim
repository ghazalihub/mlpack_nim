import ../core

{.compile: "gmm_generate_wrapper.cpp".}
{.emit: "void mlpack_gmm_generate(mlpack::util::Params&, mlpack::util::Timers&);".}
proc mlpack_gmm_generate(params: var Params, timers: var Timers) {.importcpp: "mlpack_gmm_generate(@)".}

type GMM* {.importc: "GMM".} = object
proc getGMM*(p: var Params, name: cstring): var GMM {.importcpp: "#.Get<GMM>(std::string(#))".}
proc setGMM*(p: var Params, name: cstring, val: GMM) {.importcpp: "#.Get<GMM>(std::string(#)) = #".}
proc newGMM*(): GMM {.importcpp: "GMM()".}

proc gmm_generate*(
    input_model: GMM, # Input GMM model to generate samples from.
    samples: int, # Number of samples to generate.
    seed: int = 0, # Random seed.  If 0, 'std::time(NULL)' is used.
): Mat =
  var params = newParams("gmm_generate")
  var timers = newTimers()
  setGMM(params, "input_model", input_model)
  setPassed(params, "input_model")
  setInt(params, "samples", samples)
  setPassed(params, "samples")
  setInt(params, "seed", seed)
  setPassed(params, "seed")
  setPassed(params, "output")
  mlpack_gmm_generate(params, timers)
  result = getMat(params, "output")
