# src/mlpack/core.nim
{.passC: "-std=c++17".}
{.passL: "-larmadillo".}

type
  # Armadillo types
  Mat* {.importc: "arma::mat", header: "armadillo".} = object
  Vec* {.importc: "arma::vec", header: "armadillo".} = object
  Row* {.importc: "arma::rowvec", header: "armadillo".} = object
  UMat* {.importc: "arma::Mat<size_t>", header: "armadillo".} = object
  UVec* {.importc: "arma::Col<size_t>", header: "armadillo".} = object

  # mlpack types
  Params* {.importc: "mlpack::util::Params", header: "mlpack/core/util/params.hpp".} = object
  Timers* {.importc: "mlpack::util::Timers", header: "mlpack/core/util/timers.hpp".} = object

  # C++ types
  CppString* {.importc: "std::string", header: "<string>".} = object

# String conversions
proc toCppString*(s: cstring): CppString {.importcpp: "std::string(#)", header: "<string>".}
proc `$`*(s: CppString): string {.importcpp: "(char*)#.c_str()", header: "<string>".}

# Constructors
proc newMat*(): Mat {.importcpp: "arma::mat()", header: "armadillo".}
proc newMat*(rows, cols: int): Mat {.importcpp: "arma::mat(@)", header: "armadillo".}
proc newUMat*(): UMat {.importcpp: "arma::Mat<size_t>()", header: "armadillo".}
proc newVec*(): Vec {.importcpp: "arma::vec()", header: "armadillo".}
proc newUVec*(): UVec {.importcpp: "arma::Col<size_t>()", header: "armadillo".}
proc newRow*(): Row {.importcpp: "arma::rowvec()", header: "armadillo".}

proc newParams*(name: cstring): Params {.importcpp: "mlpack::IO::Parameters(std::string(#))", header: "mlpack/core/util/io.hpp".}
proc newTimers*(): Timers {.importcpp: "mlpack::util::Timers()", header: "mlpack/core/util/timers.hpp".}

# Mat methods
proc n_rows*(m: Mat): int {.importcpp: "#.n_rows", header: "armadillo".}
proc n_cols*(m: Mat): int {.importcpp: "#.n_cols", header: "armadillo".}
proc print*(m: Mat, header: cstring = "") {.importcpp: "#.print(#)", header: "armadillo".}
proc `[]`*(m: Mat, r, c: int): float64 {.importcpp: "#(#, #)", header: "armadillo".}
proc `[]=`*(m: var Mat, r, c: int, val: float64) {.importcpp: "#(#, #) = #", header: "armadillo".}
proc randu*(m: var Mat, rows, cols: int) {.importcpp: "#.randu(#, #)", header: "armadillo".}
proc randn*(m: var Mat, rows, cols: int) {.importcpp: "#.randn(#, #)", header: "armadillo".}
proc ones*(m: var Mat, rows, cols: int) {.importcpp: "#.ones(#, #)", header: "armadillo".}
proc zeros*(m: var Mat, rows, cols: int) {.importcpp: "#.zeros(#, #)", header: "armadillo".}

proc load*(m: var Mat, filename: cstring): bool {.importcpp: "#.load(std::string(#))", header: "armadillo".}
proc save*(m: Mat, filename: cstring): bool {.importcpp: "#.save(std::string(#))", header: "armadillo".}

# Params methods
proc hasParam*(p: Params, name: cstring): bool {.importcpp: "#.Has(std::string(#))", header: "mlpack/core/util/params.hpp".}
proc setPassed*(p: var Params, name: cstring) {.importcpp: "#.SetPassed(std::string(#))", header: "mlpack/core/util/params.hpp".}

# Specific Getters
proc getInt*(p: var Params, name: cstring): int {.importcpp: "#.Get<int>(std::string(#))", header: "mlpack/core/util/params.hpp".}
proc getDouble*(p: var Params, name: cstring): float64 {.importcpp: "#.Get<double>(std::string(#))", header: "mlpack/core/util/params.hpp".}
proc getCppString*(p: var Params, name: cstring): CppString {.importcpp: "#.Get<std::string>(std::string(#))", header: "mlpack/core/util/params.hpp".}
proc getBool*(p: var Params, name: cstring): bool {.importcpp: "#.Get<bool>(std::string(#))", header: "mlpack/core/util/params.hpp".}
proc getMat*(p: var Params, name: cstring): var Mat {.importcpp: "#.Get<arma::mat>(std::string(#))", header: "mlpack/core/util/params.hpp".}
proc getUMat*(p: var Params, name: cstring): var UMat {.importcpp: "#.Get<arma::Mat<size_t>>(std::string(#))", header: "mlpack/core/util/params.hpp".}
proc getVec*(p: var Params, name: cstring): var Vec {.importcpp: "#.Get<arma::vec>(std::string(#))", header: "mlpack/core/util/params.hpp".}
proc getUVec*(p: var Params, name: cstring): var UVec {.importcpp: "#.Get<arma::Col<size_t>>(std::string(#))", header: "mlpack/core/util/params.hpp".}

# Specific Setters
proc setInt*(p: var Params, name: cstring, val: int) {.importcpp: "#.Get<int>(std::string(#)) = #", header: "mlpack/core/util/params.hpp".}
proc setDouble*(p: var Params, name: cstring, val: float64) {.importcpp: "#.Get<double>(std::string(#)) = #", header: "mlpack/core/util/params.hpp".}
proc setCppString*(p: var Params, name: cstring, val: CppString) {.importcpp: "#.Get<std::string>(std::string(#)) = #", header: "mlpack/core/util/params.hpp".}
proc setBool*(p: var Params, name: cstring, val: bool) {.importcpp: "#.Get<bool>(std::string(#)) = #", header: "mlpack/core/util/params.hpp".}
proc setMat*(p: var Params, name: cstring, val: Mat) {.importcpp: "#.Get<arma::mat>(std::string(#)) = #", header: "mlpack/core/util/params.hpp".}
proc setUMat*(p: var Params, name: cstring, val: UMat) {.importcpp: "#.Get<arma::Mat<size_t>>(std::string(#)) = #", header: "mlpack/core/util/params.hpp".}
proc setVec*(p: var Params, name: cstring, val: Vec) {.importcpp: "#.Get<arma::vec>(std::string(#)) = #", header: "mlpack/core/util/params.hpp".}
proc setUVec*(p: var Params, name: cstring, val: UVec) {.importcpp: "#.Get<arma::Col<size_t>>(std::string(#)) = #", header: "mlpack/core/util/params.hpp".}
