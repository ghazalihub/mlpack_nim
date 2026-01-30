import ../core

{.compile: "approx_kfn_wrapper.cpp".}
{.emit: "void mlpack_approx_kfn(mlpack::util::Params&, mlpack::util::Timers&);".}
proc mlpack_approx_kfn(params: var Params, timers: var Timers) {.importcpp: "mlpack_approx_kfn(@)".}

type ApproxKFNModel* {.importc: "ApproxKFNModel".} = object
proc getApproxKFNModel*(p: var Params, name: cstring): var ApproxKFNModel {.importcpp: "#.Get<ApproxKFNModel>(std::string(#))".}
proc setApproxKFNModel*(p: var Params, name: cstring, val: ApproxKFNModel) {.importcpp: "#.Get<ApproxKFNModel>(std::string(#)) = #".}
proc newApproxKFNModel*(): ApproxKFNModel {.importcpp: "ApproxKFNModel()".}

proc approx_kfn*(
    algorithm: string = "ds", # Algorithm to use: 'ds' or 'qdafn'.
    calculate_error: bool = false, # If set, calculate the average distance error for the first furthest neighbor only.
    exact_distances: Mat = newMat(), # Matrix containing exact distances to furthest neighbors; this can be used to avoid explicit calculation when --calculate_error is set.
    input_model: ApproxKFNModel = newApproxKFNModel(), # File containing input model.
    k: int = 0, # Number of furthest neighbors to search for.
    num_projections: int = 5, # Number of projections to use in each hash table.
    num_tables: int = 5, # Number of hash tables to use.
    query: Mat = newMat(), # Matrix containing query points.
    reference: Mat = newMat(), # Matrix containing the reference dataset.
): tuple[distances: Mat, neighbors: UMat, output_model: ApproxKFNModel] =
  var params = newParams("approx_kfn")
  var timers = newTimers()
  setCppString(params, "algorithm", toCppString(algorithm))
  setPassed(params, "algorithm")
  setBool(params, "calculate_error", calculate_error)
  setPassed(params, "calculate_error")
  setMat(params, "exact_distances", exact_distances)
  setPassed(params, "exact_distances")
  setApproxKFNModel(params, "input_model", input_model)
  setPassed(params, "input_model")
  setInt(params, "k", k)
  setPassed(params, "k")
  setInt(params, "num_projections", num_projections)
  setPassed(params, "num_projections")
  setInt(params, "num_tables", num_tables)
  setPassed(params, "num_tables")
  setMat(params, "query", query)
  setPassed(params, "query")
  setMat(params, "reference", reference)
  setPassed(params, "reference")
  setPassed(params, "distances")
  setPassed(params, "neighbors")
  setPassed(params, "output_model")
  mlpack_approx_kfn(params, timers)
  result.distances = getMat(params, "distances")
  result.neighbors = getUMat(params, "neighbors")
  result.output_model = getApproxKFNModel(params, "output_model")
