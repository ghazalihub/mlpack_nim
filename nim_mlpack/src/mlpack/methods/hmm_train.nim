import ../core

{.compile: "hmm_train_wrapper.cpp".}
{.emit: "void mlpack_hmm_train(mlpack::util::Params&, mlpack::util::Timers&);".}
proc mlpack_hmm_train(params: var Params, timers: var Timers) {.importcpp: "mlpack_hmm_train(@)".}

type HMMModel* {.importc: "HMMModel".} = object
proc getHMMModel*(p: var Params, name: cstring): var HMMModel {.importcpp: "#.Get<HMMModel>(std::string(#))".}
proc setHMMModel*(p: var Params, name: cstring, val: HMMModel) {.importcpp: "#.Get<HMMModel>(std::string(#)) = #".}
proc newHMMModel*(): HMMModel {.importcpp: "HMMModel()".}

proc hmm_train*(
    batch: bool = false, # If true, input_file (and if passed, labels_file) are expected to contain a list of files to use as input observation sequences (and label sequences).
    gaussians: int = 0, # Number of gaussians in each GMM (necessary when type is 'gmm').
    input_file: string, # File containing input observations.
    input_model: HMMModel = newHMMModel(), # Pre-existing HMM model to initialize training with.
    labels_file: string = "", # Optional file of hidden states, used for labeled training.
    seed: int = 0, # Random seed.  If 0, 'std::time(NULL)' is used.
    states: int = 0, # Number of hidden states in HMM (necessary, unless model_file is specified).
    tolerance: float64 = 1e-05, # Tolerance of the Baum-Welch algorithm.
    type: string = "gaussian", # Type of HMM: discrete | gaussian | diag_gmm | gmm.
): HMMModel =
  var params = newParams("hmm_train")
  var timers = newTimers()
  setBool(params, "batch", batch)
  setPassed(params, "batch")
  setInt(params, "gaussians", gaussians)
  setPassed(params, "gaussians")
  setCppString(params, "input_file", toCppString(input_file))
  setPassed(params, "input_file")
  setHMMModel(params, "input_model", input_model)
  setPassed(params, "input_model")
  setCppString(params, "labels_file", toCppString(labels_file))
  setPassed(params, "labels_file")
  setInt(params, "seed", seed)
  setPassed(params, "seed")
  setInt(params, "states", states)
  setPassed(params, "states")
  setDouble(params, "tolerance", tolerance)
  setPassed(params, "tolerance")
  setCppString(params, "type", toCppString(type))
  setPassed(params, "type")
  setPassed(params, "output_model")
  mlpack_hmm_train(params, timers)
  result = getHMMModel(params, "output_model")
