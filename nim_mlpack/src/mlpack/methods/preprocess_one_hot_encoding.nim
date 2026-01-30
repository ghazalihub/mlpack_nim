import ../core

{.compile: "preprocess_one_hot_encoding_wrapper.cpp".}
{.emit: "void mlpack_preprocess_one_hot_encoding(mlpack::util::Params&, mlpack::util::Timers&);".}
proc mlpack_preprocess_one_hot_encoding(params: var Params, timers: var Timers) {.importcpp: "mlpack_preprocess_one_hot_encoding(@)".}

type std::vector_int_* {.importc: "std::vector<int>".} = object
proc getstd::vector_int_*(p: var Params, name: cstring): var std::vector_int_ {.importcpp: "#.Get<std::vector<int>>(std::string(#))".}
proc setstd::vector_int_*(p: var Params, name: cstring, val: std::vector_int_) {.importcpp: "#.Get<std::vector<int>>(std::string(#)) = #".}
proc newstd::vector_int_*(): std::vector_int_ {.importcpp: "std::vector<int>()".}

proc preprocess_one_hot_encoding*(
    dimensions: std::vector_int_ = newstd::vector_int_(), # Index of dimensions that need to be one-hot encoded (if unspecified, all categorical dimensions are one-hot encoded).
    input: string, # Matrix containing data.
): Mat =
  var params = newParams("preprocess_one_hot_encoding")
  var timers = newTimers()
  setstd::vector_int_(params, "dimensions", dimensions)
  setPassed(params, "dimensions")
  setCppString(params, "input", toCppString(input))
  setPassed(params, "input")
  setPassed(params, "output")
  mlpack_preprocess_one_hot_encoding(params, timers)
  result = getMat(params, "output")
