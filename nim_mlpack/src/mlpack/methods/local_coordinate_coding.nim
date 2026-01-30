import ../core

{.compile: "local_coordinate_coding_wrapper.cpp".}
{.emit: "void mlpack_local_coordinate_coding(mlpack::util::Params&, mlpack::util::Timers&);".}
proc mlpack_local_coordinate_coding(params: var Params, timers: var Timers) {.importcpp: "mlpack_local_coordinate_coding(@)".}

proc local_coordinate_coding*(
    atoms: int = 0, # Number of atoms in the dictionary.
    initial_dictionary: Mat = newMat(), # Optional initial dictionary.
    input_model: Mat = newMat(), # Input LCC model.
    lambda: float64 = 0, # Weighted l1-norm regularization parameter.
    max_iterations: int = 0, # Maximum number of iterations for LCC (0 indicates no limit).
    normalize: bool = false, # If set, the input data matrix will be normalized before coding.
    seed: int = 0, # Random seed.  If 0, 'std::time(NULL)' is used.
    test: Mat = newMat(), # Test points to encode.
    tolerance: float64 = 0.01, # Tolerance for objective function.
    training: Mat = newMat(), # Matrix of training data (X).
): tuple[codes: Mat, dictionary: Mat, output_model: Mat] =
  var params = newParams("local_coordinate_coding")
  var timers = newTimers()
  setInt(params, "atoms", atoms)
  setPassed(params, "atoms")
  setMat(params, "initial_dictionary", initial_dictionary)
  setPassed(params, "initial_dictionary")
  setMat(params, "input_model", input_model)
  setPassed(params, "input_model")
  setDouble(params, "lambda", lambda)
  setPassed(params, "lambda")
  setInt(params, "max_iterations", max_iterations)
  setPassed(params, "max_iterations")
  setBool(params, "normalize", normalize)
  setPassed(params, "normalize")
  setInt(params, "seed", seed)
  setPassed(params, "seed")
  setMat(params, "test", test)
  setPassed(params, "test")
  setDouble(params, "tolerance", tolerance)
  setPassed(params, "tolerance")
  setMat(params, "training", training)
  setPassed(params, "training")
  setPassed(params, "codes")
  setPassed(params, "dictionary")
  setPassed(params, "output_model")
  mlpack_local_coordinate_coding(params, timers)
  result.codes = getMat(params, "codes")
  result.dictionary = getMat(params, "dictionary")
  result.output_model = getMat(params, "output_model")
