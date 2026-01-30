import ../core

{.compile: "emst_wrapper.cpp".}
{.emit: "void mlpack_emst(mlpack::util::Params&, mlpack::util::Timers&);".}
proc mlpack_emst(params: var Params, timers: var Timers) {.importcpp: "mlpack_emst(@)".}

proc emst*(
    input: Mat, # Input data matrix.
    leaf_size: int = 1, # Leaf size in the kd-tree.  One-element leaves give the empirically best performance, but at the cost of greater memory requirements.
    naive: bool = false, # Compute the MST using O(n^2) naive algorithm.
): Mat =
  var params = newParams("emst")
  var timers = newTimers()
  setMat(params, "input", input)
  setPassed(params, "input")
  setInt(params, "leaf_size", leaf_size)
  setPassed(params, "leaf_size")
  setBool(params, "naive", naive)
  setPassed(params, "naive")
  setPassed(params, "output")
  mlpack_emst(params, timers)
  result = getMat(params, "output")
