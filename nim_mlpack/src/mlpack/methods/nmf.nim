import ../core

{.compile: "nmf_wrapper.cpp".}
{.emit: "void mlpack_nmf(mlpack::util::Params&, mlpack::util::Timers&);".}
proc mlpack_nmf(params: var Params, timers: var Timers) {.importcpp: "mlpack_nmf(@)".}

proc nmf*(
    initial_h: Mat = newMat(), # Initial H matrix.
    initial_w: Mat = newMat(), # Initial W matrix.
    input: Mat, # Input dataset to perform NMF on.
    max_iterations: int = 10000, # Number of iterations before NMF terminates (0 runs until convergence.
    min_residue: float64 = 1e-05, # The minimum root mean square residue allowed for each iteration, below which the program terminates.
    rank: int, # Rank of the factorization.
    seed: int = 0, # Random seed.  If 0, 'std::time(NULL)' is used.
    update_rules: string = "multdist", # Update rules for each iteration; ( multdist | multdiv | als ).
): tuple[h: Mat, w: Mat] =
  var params = newParams("nmf")
  var timers = newTimers()
  setMat(params, "initial_h", initial_h)
  setPassed(params, "initial_h")
  setMat(params, "initial_w", initial_w)
  setPassed(params, "initial_w")
  setMat(params, "input", input)
  setPassed(params, "input")
  setInt(params, "max_iterations", max_iterations)
  setPassed(params, "max_iterations")
  setDouble(params, "min_residue", min_residue)
  setPassed(params, "min_residue")
  setInt(params, "rank", rank)
  setPassed(params, "rank")
  setInt(params, "seed", seed)
  setPassed(params, "seed")
  setCppString(params, "update_rules", toCppString(update_rules))
  setPassed(params, "update_rules")
  setPassed(params, "h")
  setPassed(params, "w")
  mlpack_nmf(params, timers)
  result.h = getMat(params, "h")
  result.w = getMat(params, "w")
