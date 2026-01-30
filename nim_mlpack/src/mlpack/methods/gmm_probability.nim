import ../core

{.compile: "gmm_probability_wrapper.cpp".}
{.emit: "void mlpack_gmm_probability(mlpack::util::Params&, mlpack::util::Timers&);".}
proc mlpack_gmm_probability(params: var Params, timers: var Timers) {.importcpp: "mlpack_gmm_probability(@)".}

type GMM* {.importc: "GMM".} = object
proc getGMM*(p: var Params, name: cstring): var GMM {.importcpp: "#.Get<GMM>(std::string(#))".}
proc setGMM*(p: var Params, name: cstring, val: GMM) {.importcpp: "#.Get<GMM>(std::string(#)) = #".}
proc newGMM*(): GMM {.importcpp: "GMM()".}

proc gmm_probability*(
    input: Mat, # Input matrix to calculate probabilities of.
    input_model: GMM, # Input GMM to use as model.
): Mat =
  var params = newParams("gmm_probability")
  var timers = newTimers()
  setMat(params, "input", input)
  setPassed(params, "input")
  setGMM(params, "input_model", input_model)
  setPassed(params, "input_model")
  setPassed(params, "output")
  mlpack_gmm_probability(params, timers)
  result = getMat(params, "output")
