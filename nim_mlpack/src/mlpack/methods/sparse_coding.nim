import ../core

{.compile: "sparse_coding_wrapper.cpp".}
{.emit: "void mlpack_sparse_coding(mlpack::util::Params&, mlpack::util::Timers&);".}
proc mlpack_sparse_coding(params: var Params, timers: var Timers) {.importcpp: "mlpack_sparse_coding(@)".}

proc sparse_coding*(
    atoms: int = 15, # Number of atoms in the dictionary.
    initial_dictionary: Mat = newMat(), # Optional initial dictionary matrix.
    input_model: Mat = newMat(), # File containing input sparse coding model.
    lambda1: float64 = 0, # Sparse coding l1-norm regularization parameter.
    lambda2: float64 = 0, # Sparse coding l2-norm regularization parameter.
    max_iterations: int = 0, # Maximum number of iterations for sparse coding (0 indicates no limit).
    newton_tolerance: float64 = 1e-06, # Tolerance for convergence of Newton method.
    normalize: bool = false, # If set, the input data matrix will be normalized before coding.
    objective_tolerance: float64 = 0.01, # Tolerance for convergence of the objective function.
    seed: int = 0, # Random seed.  If 0, 'std::time(NULL)' is used.
    test: Mat = newMat(), # Optional matrix to be encoded by trained model.
    training: Mat = newMat(), # Matrix of training data (X).
): tuple[codes: Mat, dictionary: Mat, output_model: Mat] =
  var params = newParams("sparse_coding")
  var timers = newTimers()
  setInt(params, "atoms", atoms)
  setPassed(params, "atoms")
  setMat(params, "initial_dictionary", initial_dictionary)
  setPassed(params, "initial_dictionary")
  setMat(params, "input_model", input_model)
  setPassed(params, "input_model")
  setDouble(params, "lambda1", lambda1)
  setPassed(params, "lambda1")
  setDouble(params, "lambda2", lambda2)
  setPassed(params, "lambda2")
  setInt(params, "max_iterations", max_iterations)
  setPassed(params, "max_iterations")
  setDouble(params, "newton_tolerance", newton_tolerance)
  setPassed(params, "newton_tolerance")
  setBool(params, "normalize", normalize)
  setPassed(params, "normalize")
  setDouble(params, "objective_tolerance", objective_tolerance)
  setPassed(params, "objective_tolerance")
  setInt(params, "seed", seed)
  setPassed(params, "seed")
  setMat(params, "test", test)
  setPassed(params, "test")
  setMat(params, "training", training)
  setPassed(params, "training")
  setPassed(params, "codes")
  setPassed(params, "dictionary")
  setPassed(params, "output_model")
  mlpack_sparse_coding(params, timers)
  result.codes = getMat(params, "codes")
  result.dictionary = getMat(params, "dictionary")
  result.output_model = getMat(params, "output_model")
