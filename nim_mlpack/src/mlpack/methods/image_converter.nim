import ../core

{.compile: "image_converter_wrapper.cpp".}
{.emit: "void mlpack_image_converter(mlpack::util::Params&, mlpack::util::Timers&);".}
proc mlpack_image_converter(params: var Params, timers: var Timers) {.importcpp: "mlpack_image_converter(@)".}

proc image_converter*(
    channels: int = 0, # Number of channels in the image.
    dataset: Mat = newMat(), # Input matrix to save as images.
    height: int = 0, # Height of the images.
    input: string, # Image filenames which have to be loaded/saved.
    quality: int = 90, # Compression of the image if saved as jpg (0-100).
    save: bool = false, # Save a dataset as images.
    width: int = 0, # Width of the image.
): Mat =
  var params = newParams("image_converter")
  var timers = newTimers()
  setInt(params, "channels", channels)
  setPassed(params, "channels")
  setMat(params, "dataset", dataset)
  setPassed(params, "dataset")
  setInt(params, "height", height)
  setPassed(params, "height")
  setCppString(params, "input", toCppString(input))
  setPassed(params, "input")
  setInt(params, "quality", quality)
  setPassed(params, "quality")
  setBool(params, "save", save)
  setPassed(params, "save")
  setInt(params, "width", width)
  setPassed(params, "width")
  setPassed(params, "output")
  mlpack_image_converter(params, timers)
  result = getMat(params, "output")
