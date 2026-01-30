import ../core

{.compile: "radical_wrapper.cpp".}
{.emit: "void mlpack_radical(mlpack::util::Params&, mlpack::util::Timers&);".}
proc mlpack_radical(params: var Params, timers: var Timers) {.importcpp: "mlpack_radical(@)".}

proc radical*(
    angles: int = 150, # Number of angles to consider in brute-force search during Radical2D.
    input: Mat, # Input dataset for ICA.
    noise_std_dev: float64 = 0.175, # Standard deviation of Gaussian noise.
    objective: bool = false, # If set, an estimate of the final objective function is printed.
    replicates: int = 30, # Number of Gaussian-perturbed replicates to use (per point) in Radical2D.
    seed: int = 0, # Random seed.  If 0, 'std::time(NULL)' is used.
    sweeps: int = 0, # Number of sweeps; each sweep calls Radical2D once for each pair of dimensions.
): tuple[output_ic: Mat, output_unmixing: Mat] =
  var params = newParams("radical")
  var timers = newTimers()
  setInt(params, "angles", angles)
  setPassed(params, "angles")
  setMat(params, "input", input)
  setPassed(params, "input")
  setDouble(params, "noise_std_dev", noise_std_dev)
  setPassed(params, "noise_std_dev")
  setBool(params, "objective", objective)
  setPassed(params, "objective")
  setInt(params, "replicates", replicates)
  setPassed(params, "replicates")
  setInt(params, "seed", seed)
  setPassed(params, "seed")
  setInt(params, "sweeps", sweeps)
  setPassed(params, "sweeps")
  setPassed(params, "output_ic")
  setPassed(params, "output_unmixing")
  mlpack_radical(params, timers)
  result.output_ic = getMat(params, "output_ic")
  result.output_unmixing = getMat(params, "output_unmixing")
