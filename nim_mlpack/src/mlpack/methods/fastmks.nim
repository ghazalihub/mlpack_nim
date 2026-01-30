import ../core

{.compile: "fastmks_wrapper.cpp".}
{.emit: "void mlpack_fastmks(mlpack::util::Params&, mlpack::util::Timers&);".}
proc mlpack_fastmks(params: var Params, timers: var Timers) {.importcpp: "mlpack_fastmks(@)".}

type FastMKSModel* {.importc: "FastMKSModel".} = object
proc getFastMKSModel*(p: var Params, name: cstring): var FastMKSModel {.importcpp: "#.Get<FastMKSModel>(std::string(#))".}
proc setFastMKSModel*(p: var Params, name: cstring, val: FastMKSModel) {.importcpp: "#.Get<FastMKSModel>(std::string(#)) = #".}
proc newFastMKSModel*(): FastMKSModel {.importcpp: "FastMKSModel()".}

proc fastmks*(
    bandwidth: float64 = 1, # Bandwidth (for Gaussian, Epanechnikov, and triangular kernels).
    base: float64 = 2, # Base to use during cover tree construction.
    degree: float64 = 2, # Degree of polynomial kernel.
    input_model: FastMKSModel = newFastMKSModel(), # Input FastMKS model to use.
    k: int = 0, # Number of maximum kernels to find.
    kernel: string = "linear", # Kernel type to use: 'linear', 'polynomial', 'cosine', 'gaussian', 'epanechnikov', 'triangular', 'hyptan'.
    naive: bool = false, # If true, O(n^2) naive mode is used for computation.
    offset: float64 = 0, # Offset of kernel (for polynomial and hyptan kernels).
    query: Mat = newMat(), # The query dataset.
    reference: Mat = newMat(), # The reference dataset.
    scale: float64 = 1, # Scale of kernel (for hyptan kernel).
    single: bool = false, # If true, single-tree search is used (as opposed to dual-tree search.
): tuple[indices: UMat, kernels: Mat, output_model: FastMKSModel] =
  var params = newParams("fastmks")
  var timers = newTimers()
  setDouble(params, "bandwidth", bandwidth)
  setPassed(params, "bandwidth")
  setDouble(params, "base", base)
  setPassed(params, "base")
  setDouble(params, "degree", degree)
  setPassed(params, "degree")
  setFastMKSModel(params, "input_model", input_model)
  setPassed(params, "input_model")
  setInt(params, "k", k)
  setPassed(params, "k")
  setCppString(params, "kernel", toCppString(kernel))
  setPassed(params, "kernel")
  setBool(params, "naive", naive)
  setPassed(params, "naive")
  setDouble(params, "offset", offset)
  setPassed(params, "offset")
  setMat(params, "query", query)
  setPassed(params, "query")
  setMat(params, "reference", reference)
  setPassed(params, "reference")
  setDouble(params, "scale", scale)
  setPassed(params, "scale")
  setBool(params, "single", single)
  setPassed(params, "single")
  setPassed(params, "indices")
  setPassed(params, "kernels")
  setPassed(params, "output_model")
  mlpack_fastmks(params, timers)
  result.indices = getUMat(params, "indices")
  result.kernels = getMat(params, "kernels")
  result.output_model = getFastMKSModel(params, "output_model")
