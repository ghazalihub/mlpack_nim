import ../core

{.compile: "gmm_train_wrapper.cpp".}
{.emit: "void mlpack_gmm_train(mlpack::util::Params&, mlpack::util::Timers&);".}
proc mlpack_gmm_train(params: var Params, timers: var Timers) {.importcpp: "mlpack_gmm_train(@)".}

type GMM* {.importc: "GMM".} = object
proc getGMM*(p: var Params, name: cstring): var GMM {.importcpp: "#.Get<GMM>(std::string(#))".}
proc setGMM*(p: var Params, name: cstring, val: GMM) {.importcpp: "#.Get<GMM>(std::string(#)) = #".}
proc newGMM*(): GMM {.importcpp: "GMM()".}

proc gmm_train*(
    diagonal_covariance: bool = false, # Force the covariance of the Gaussians to be diagonal.  This can accelerate training time significantly.
    gaussians: int, # Number of Gaussians in the GMM.
    input: Mat, # The training data on which the model will be fit.
    input_model: GMM = newGMM(), # Initial input GMM model to start training with.
    kmeans_max_iterations: int = 1000, # Maximum number of iterations for the k-means algorithm (used to initialize EM).
    max_iterations: int = 250, # Maximum number of iterations of EM algorithm (passing 0 will run until convergence).
    no_force_positive: bool = false, # Do not force the covariance matrices to be positive definite.
    noise: float64 = 0, # Variance of zero-mean Gaussian noise to add to data.
    percentage: float64 = 0.02, # If using --refined_start, specify the percentage of the dataset used for each sampling (should be between 0.0 and 1.0).
    refined_start: bool = false, # During the initialization, use refined initial positions for k-means clustering (Bradley and Fayyad, 1998).
    samplings: int = 100, # If using --refined_start, specify the number of samplings used for initial points.
    seed: int = 0, # Random seed.  If 0, 'std::time(NULL)' is used.
    tolerance: float64 = 1e-10, # Tolerance for convergence of EM.
    trials: int = 1, # Number of trials to perform in training GMM.
): GMM =
  var params = newParams("gmm_train")
  var timers = newTimers()
  setBool(params, "diagonal_covariance", diagonal_covariance)
  setPassed(params, "diagonal_covariance")
  setInt(params, "gaussians", gaussians)
  setPassed(params, "gaussians")
  setMat(params, "input", input)
  setPassed(params, "input")
  setGMM(params, "input_model", input_model)
  setPassed(params, "input_model")
  setInt(params, "kmeans_max_iterations", kmeans_max_iterations)
  setPassed(params, "kmeans_max_iterations")
  setInt(params, "max_iterations", max_iterations)
  setPassed(params, "max_iterations")
  setBool(params, "no_force_positive", no_force_positive)
  setPassed(params, "no_force_positive")
  setDouble(params, "noise", noise)
  setPassed(params, "noise")
  setDouble(params, "percentage", percentage)
  setPassed(params, "percentage")
  setBool(params, "refined_start", refined_start)
  setPassed(params, "refined_start")
  setInt(params, "samplings", samplings)
  setPassed(params, "samplings")
  setInt(params, "seed", seed)
  setPassed(params, "seed")
  setDouble(params, "tolerance", tolerance)
  setPassed(params, "tolerance")
  setInt(params, "trials", trials)
  setPassed(params, "trials")
  setPassed(params, "output_model")
  mlpack_gmm_train(params, timers)
  result = getGMM(params, "output_model")
