import ../core

{.compile: "preprocess_describe_wrapper.cpp".}
{.emit: "void mlpack_preprocess_describe(mlpack::util::Params&, mlpack::util::Timers&);".}
proc mlpack_preprocess_describe(params: var Params, timers: var Timers) {.importcpp: "mlpack_preprocess_describe(@)".}

proc preprocess_describe*(
    dimension: int = 0, # Dimension of the data. Use this to specify a dimension
    input: Mat, # Matrix containing data,
    population: bool = false, # If specified, the program will calculate statistics assuming the dataset is the population. By default, the program will assume the dataset as a sample.
    precision: int = 4, # Precision of the output statistics.
    row_major: bool = false, # If specified, the program will calculate statistics across rows, not across columns.  (Remember that in mlpack, a column represents a point, so this option is generally not necessary.)
    width: int = 8 # Width of the output table.
) =
  var params = newParams("preprocess_describe")
  var timers = newTimers()
  setInt(params, "dimension", dimension)
  setPassed(params, "dimension")
  setMat(params, "input", input)
  setPassed(params, "input")
  setBool(params, "population", population)
  setPassed(params, "population")
  setInt(params, "precision", precision)
  setPassed(params, "precision")
  setBool(params, "row_major", row_major)
  setPassed(params, "row_major")
  setInt(params, "width", width)
  setPassed(params, "width")
  mlpack_preprocess_describe(params, timers)
