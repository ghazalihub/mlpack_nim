import ../core

{.compile: "kmeans_wrapper.cpp".}
{.emit: "void mlpack_kmeans(mlpack::util::Params&, mlpack::util::Timers&);".}
proc mlpack_kmeans(params: var Params, timers: var Timers) {.importcpp: "mlpack_kmeans(@)".}

proc kmeans*(
    algorithm: string = "naive", # Algorithm to use for the Lloyd iteration ('naive', 'pelleg-moore', 'elkan', 'hamerly', 'dualtree', or 'dualtree-covertree').
    allow_empty_clusters: bool = false, # Allow empty clusters to be persist.
    clusters: int, # Number of clusters to find (0 autodetects from initial centroids).
    in_place: bool = false, # If specified, a column containing the learned cluster assignments will be added to the input dataset file.  In this case, --output_file is overridden. (Do not use in Python.)
    initial_centroids: Mat = newMat(), # Start with the specified initial centroids.
    input: Mat, # Input dataset to perform clustering on.
    kill_empty_clusters: bool = false, # Remove empty clusters when they occur.
    kmeans_plus_plus: bool = false, # Use the k-means++ initialization strategy to choose initial points.
    labels_only: bool = false, # Only output labels into output file.
    max_iterations: int = 1000, # Maximum number of iterations before k-means terminates.
    percentage: float64 = 0.02, # Percentage of dataset to use for each refined start sampling (use when --refined_start is specified).
    refined_start: bool = false, # Use the refined initial point strategy by Bradley and Fayyad to choose initial points.
    samplings: int = 100, # Number of samplings to perform for refined start (use when --refined_start is specified).
    seed: int = 0, # Random seed.  If 0, 'std::time(NULL)' is used.
): tuple[centroid: Mat, output: Mat] =
  var params = newParams("kmeans")
  var timers = newTimers()
  setCppString(params, "algorithm", toCppString(algorithm))
  setPassed(params, "algorithm")
  setBool(params, "allow_empty_clusters", allow_empty_clusters)
  setPassed(params, "allow_empty_clusters")
  setInt(params, "clusters", clusters)
  setPassed(params, "clusters")
  setBool(params, "in_place", in_place)
  setPassed(params, "in_place")
  setMat(params, "initial_centroids", initial_centroids)
  setPassed(params, "initial_centroids")
  setMat(params, "input", input)
  setPassed(params, "input")
  setBool(params, "kill_empty_clusters", kill_empty_clusters)
  setPassed(params, "kill_empty_clusters")
  setBool(params, "kmeans_plus_plus", kmeans_plus_plus)
  setPassed(params, "kmeans_plus_plus")
  setBool(params, "labels_only", labels_only)
  setPassed(params, "labels_only")
  setInt(params, "max_iterations", max_iterations)
  setPassed(params, "max_iterations")
  setDouble(params, "percentage", percentage)
  setPassed(params, "percentage")
  setBool(params, "refined_start", refined_start)
  setPassed(params, "refined_start")
  setInt(params, "samplings", samplings)
  setPassed(params, "samplings")
  setInt(params, "seed", seed)
  setPassed(params, "seed")
  setPassed(params, "centroid")
  setPassed(params, "output")
  mlpack_kmeans(params, timers)
  result.centroid = getMat(params, "centroid")
  result.output = getMat(params, "output")
