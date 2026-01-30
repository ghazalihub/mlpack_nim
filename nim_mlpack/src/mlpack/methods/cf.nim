import ../core

{.compile: "cf_wrapper.cpp".}
{.emit: "void mlpack_cf(mlpack::util::Params&, mlpack::util::Timers&);".}
proc mlpack_cf(params: var Params, timers: var Timers) {.importcpp: "mlpack_cf(@)".}

type CFModel* {.importc: "CFModel".} = object
proc getCFModel*(p: var Params, name: cstring): var CFModel {.importcpp: "#.Get<CFModel>(std::string(#))".}
proc setCFModel*(p: var Params, name: cstring, val: CFModel) {.importcpp: "#.Get<CFModel>(std::string(#)) = #".}
proc newCFModel*(): CFModel {.importcpp: "CFModel()".}

proc cf*(
    algorithm: string = "NMF", # Algorithm used for matrix factorization.
    all_user_recommendations: bool = false, # Generate recommendations for all users.
    input_model: CFModel = newCFModel(), # Trained CF model to load.
    interpolation: string = "average", # Algorithm used for weight interpolation.
    iteration_only_termination: bool = false, # Terminate only when the maximum number of iterations is reached.
    max_iterations: int = 1000, # Maximum number of iterations. If set to zero, there is no limit on the number of iterations.
    min_residue: float64 = 1e-05, # Residue required to terminate the factorization (lower values generally mean better fits).
    neighbor_search: string = "euclidean", # Algorithm used for neighbor search.
    neighborhood: int = 5, # Size of the neighborhood of similar users to consider for each query user.
    normalization: string = "none", # Normalization performed on the ratings.
    query: UMat = newUMat(), # List of query users for which recommendations should be generated.
    rank: int = 0, # Rank of decomposed matrices (if 0, a heuristic is used to estimate the rank).
    recommendations: int = 5, # Number of recommendations to generate for each query user.
    seed: int = 0, # Set the random seed (0 uses std::time(NULL)).
    test: Mat = newMat(), # Test set to calculate RMSE on.
    training: Mat = newMat(), # Input dataset to perform CF on.
): tuple[output: UMat, output_model: CFModel] =
  var params = newParams("cf")
  var timers = newTimers()
  setCppString(params, "algorithm", toCppString(algorithm))
  setPassed(params, "algorithm")
  setBool(params, "all_user_recommendations", all_user_recommendations)
  setPassed(params, "all_user_recommendations")
  setCFModel(params, "input_model", input_model)
  setPassed(params, "input_model")
  setCppString(params, "interpolation", toCppString(interpolation))
  setPassed(params, "interpolation")
  setBool(params, "iteration_only_termination", iteration_only_termination)
  setPassed(params, "iteration_only_termination")
  setInt(params, "max_iterations", max_iterations)
  setPassed(params, "max_iterations")
  setDouble(params, "min_residue", min_residue)
  setPassed(params, "min_residue")
  setCppString(params, "neighbor_search", toCppString(neighbor_search))
  setPassed(params, "neighbor_search")
  setInt(params, "neighborhood", neighborhood)
  setPassed(params, "neighborhood")
  setCppString(params, "normalization", toCppString(normalization))
  setPassed(params, "normalization")
  setUMat(params, "query", query)
  setPassed(params, "query")
  setInt(params, "rank", rank)
  setPassed(params, "rank")
  setInt(params, "recommendations", recommendations)
  setPassed(params, "recommendations")
  setInt(params, "seed", seed)
  setPassed(params, "seed")
  setMat(params, "test", test)
  setPassed(params, "test")
  setMat(params, "training", training)
  setPassed(params, "training")
  setPassed(params, "output")
  setPassed(params, "output_model")
  mlpack_cf(params, timers)
  result.output = getUMat(params, "output")
  result.output_model = getCFModel(params, "output_model")
