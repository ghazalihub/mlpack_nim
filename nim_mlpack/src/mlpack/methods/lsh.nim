import ../core

{.compile: "lsh_wrapper.cpp".}
{.emit: "void mlpack_lsh(mlpack::util::Params&, mlpack::util::Timers&);".}
proc mlpack_lsh(params: var Params, timers: var Timers) {.importcpp: "mlpack_lsh(@)".}

proc lsh*(
    bucket_size: int = 500, # The size of a bucket in the second level hash.
    hash_width: float64 = 0, # The hash width for the first-level hashing in the LSH preprocessing. By default, the LSH class automatically estimates a hash width for its use.
    input_model: Mat = newMat(), # Input LSH model.
    k: int = 0, # Number of nearest neighbors to find.
    num_probes: int = 0, # Number of additional probes for multiprobe LSH; if 0, traditional LSH is used.
    projections: int = 10, # The number of hash functions for each table
    query: Mat = newMat(), # Matrix containing query points (optional).
    reference: Mat = newMat(), # Matrix containing the reference dataset.
    second_hash_size: int = 99901, # The size of the second level hash table.
    seed: int = 0, # Random seed.  If 0, 'std::time(NULL)' is used.
    tables: int = 30, # The number of hash tables to be used.
    true_neighbors: UMat = newUMat(), # Matrix of true neighbors to compute recall with (the recall is printed when -v is specified).
): tuple[distances: Mat, neighbors: UMat, output_model: Mat] =
  var params = newParams("lsh")
  var timers = newTimers()
  setInt(params, "bucket_size", bucket_size)
  setPassed(params, "bucket_size")
  setDouble(params, "hash_width", hash_width)
  setPassed(params, "hash_width")
  setMat(params, "input_model", input_model)
  setPassed(params, "input_model")
  setInt(params, "k", k)
  setPassed(params, "k")
  setInt(params, "num_probes", num_probes)
  setPassed(params, "num_probes")
  setInt(params, "projections", projections)
  setPassed(params, "projections")
  setMat(params, "query", query)
  setPassed(params, "query")
  setMat(params, "reference", reference)
  setPassed(params, "reference")
  setInt(params, "second_hash_size", second_hash_size)
  setPassed(params, "second_hash_size")
  setInt(params, "seed", seed)
  setPassed(params, "seed")
  setInt(params, "tables", tables)
  setPassed(params, "tables")
  setUMat(params, "true_neighbors", true_neighbors)
  setPassed(params, "true_neighbors")
  setPassed(params, "distances")
  setPassed(params, "neighbors")
  setPassed(params, "output_model")
  mlpack_lsh(params, timers)
  result.distances = getMat(params, "distances")
  result.neighbors = getUMat(params, "neighbors")
  result.output_model = getMat(params, "output_model")
