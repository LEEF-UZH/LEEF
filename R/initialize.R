#' Create folder structure for data import and processing
#'
#' @param config_file config file to use. If none is specified, \code{cofig.yml} in the current working directory will be used.
#'
#' @return invisible \code{TRUE}
#'
#' @importFrom yaml yaml.load_file
#' @importFrom magrittr %>%
#' @importFrom ROriginStamp ROriginStamp_options
#'
#' @export
#'
#' @examples
#' \dontrun{
#' initialize(system.file("default_config.yml", package = "LEEF.Data"))
#' }
initialize <- function(
  config_file,
  library_path
){

  # Define default config file ----------------------------------------------

  if (missing(config_file)) {
    config_file <- system.file("default_config.yml", package = "LEEF.Data")
  }

  # Load Config -------------------------------------------------------------

  LEEF_options <- yaml::yaml.load_file(
    system.file("default_config.yml", package = "LEEF.Data")
  )

  options(LEEF.Data = LEEF_options)


  # Fix missing directories -------------------------------------------------


  if ( is.null(opt_directories()$raw) ) {
    opt_directories( raw = getwd() )
  }

  if (is.null(opt_directories()$pre_processed)) {
    opt_directories( pre_processed = file.path( opt_directories()$raw, "..", "pre_processed" ) )
  }

  if (is.null(opt_directories()$extracted)) {
    opt_directories( extracted = file.path( opt_directories()$raw, "..", "extracted" ) )
  }

  if (is.null(opt_directories()$archive)) {
    opt_directories( archive = file.path( opt_directories()$raw, "..", "archive" ) )
  }

  # Set library path --------------------------------------------------------

  if (missing(library_path)) {
    library_path <- opt_library()
  }
  if (is.null(library_path)) {
    library_path <- tempfile("library_")
  }
  if (library_path == "") {
    library_path <- tempfile("library_")
  }
  opt_library(library_path = library_path)


  # Load measurement packages -----------------------------------------------


  install_register_packages(LEEF_options$measurement_packages)


  # Load archival packages --------------------------------------------------


  install_register_packages(LEEF_options$archival_packages)




}
