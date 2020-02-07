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
  config_file
){

  # Define default config file ----------------------------------------------

  if (missing(config_file)) {
    config_file <- system.file("default_config.yml", package = "LEEF.Data")
  }

  # Load Config -------------------------------------------------------------

  LEEF_options <- yaml::yaml.load_file(
    system.file("default_config.yml", package = "LEEF.Data")
  )

  # Fix missing directories -------------------------------------------------


  if (is.null(LEEF_options$directories$raw)) {
    LEEF_options$directories$raw <- getwd()
  }

  if (is.null(LEEF_options$directories$pre_processed)) {
    LEEF_options$directories$pre_processed <- file.path(
      LEEF_options$directories$raw,
      "..",
      "pre_processed"
    )
  }

  if (is.null(LEEF_options$directories$extracted)) {
    LEEF_options$directories$extracted <- file.path(
      LEEF_options$directories$raw,
      "..",
      "extracted"
    )
  }

  if (is.null(LEEF_options$directories$archive)) {
    LEEF_options$directories$archive <- file.path(
      LEEF_options$directories$raw,
      "..",
      "archived"
    )
  }


  # Load measurement packages -----------------------------------------------

  install_register_packages(LEEF_options$measurement_packages)

  # Load archival packages --------------------------------------------------


  install_register_packages(LEEF_options$archival_packages)


  # Write to options() ------------------------------------------------------

  options(LEEF.Data = LEEF_options)


}
