import ../core

{.compile: "kernel_pca_wrapper.cpp".}
{.emit: "void mlpack_kernel_pca(mlpack::util::Params&, mlpack::util::Timers&);".}
proc mlpack_kernel_pca(params: var Params, timers: var Timers) {.importcpp: "mlpack_kernel_pca(@)".}

proc kernel_pca*(
    bandwidth: float64 = 1, # Bandwidth, for 'gaussian' and 'laplacian' kernels.
    center: bool = false, # If set, the transformed data will be centered about the origin.
    degree: float64 = 1, # Degree of polynomial, for 'polynomial' kernel.
    input: Mat, # Input dataset to perform KPCA on.
    kernel: string, # The kernel to use; see the above documentation for the list of usable kernels.
    kernel_scale: float64 = 1, # Scale, for 'hyptan' kernel.
    new_dimensionality: int = 0, # If not 0, reduce the dimensionality of the output dataset by ignoring the dimensions with the smallest eigenvalues.
    nystroem_method: bool = false, # If set, the Nystroem method will be used.
    offset: float64 = 0, # Offset, for 'hyptan' and 'polynomial' kernels.
    sampling: string = "kmeans", # Sampling scheme to use for the Nystroem method: 'kmeans', 'random', 'ordered'
): Mat =
  var params = newParams("kernel_pca")
  var timers = newTimers()
  setDouble(params, "bandwidth", bandwidth)
  setPassed(params, "bandwidth")
  setBool(params, "center", center)
  setPassed(params, "center")
  setDouble(params, "degree", degree)
  setPassed(params, "degree")
  setMat(params, "input", input)
  setPassed(params, "input")
  setCppString(params, "kernel", toCppString(kernel))
  setPassed(params, "kernel")
  setDouble(params, "kernel_scale", kernel_scale)
  setPassed(params, "kernel_scale")
  setInt(params, "new_dimensionality", new_dimensionality)
  setPassed(params, "new_dimensionality")
  setBool(params, "nystroem_method", nystroem_method)
  setPassed(params, "nystroem_method")
  setDouble(params, "offset", offset)
  setPassed(params, "offset")
  setCppString(params, "sampling", toCppString(sampling))
  setPassed(params, "sampling")
  setPassed(params, "output")
  mlpack_kernel_pca(params, timers)
  result = getMat(params, "output")
