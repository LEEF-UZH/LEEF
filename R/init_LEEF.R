#' Create folder structure for data import and processing
#'
#' @param config_file config file to use. If none is specified, \code{cofig.yml} in the current working directory will be used.
#' @param id id which will be appended to the name in the config file, using a '.'
#'
#' @return invisible \code{TRUE}
#'
#' @importFrom yaml yaml.load_file write_yaml
#'
#' @export
#'
#' @examples
#' \dontrun{
#' init_LEEF(system.file("default_config.yml", package = "LEEF"))
#' }
init_LEEF <- function(
  config_file = system.file("default_config.yml", package = "LEEF"),
  id = NULL
){

  # Load Config -------------------------------------------------------------

  LEEF_options <- yaml::yaml.load_file(
    config_file
  )

  if (!is.null(id)) {
    if (id != "" ) {
      LEEF_options$name <- paste(LEEF_options$name, id, sep = ".")
    }
  }

  options(LEEF = LEEF_options)


  # Fix missing directories -------------------------------------------------

  if ( is.null(opt_directories()$general.parameter) ) {
    opt_directories( general.parameter = file.path( ".", "00.general.parameter" )  )
  }
  dir.create(opt_directories()$general.parameter, recursive = TRUE, showWarnings = FALSE)
  
  if ( is.null(opt_directories()$raw) ) {
    opt_directories( raw = file.path( ".", "0.raw.data" ) )
  }
  dir.create(opt_directories()$raw, recursive = TRUE, showWarnings = FALSE)

  if (is.null(opt_directories()$pre_processed)) {
    opt_directories( pre_processed = file.path( opt_directories()$raw, "..", "1.pre_processed.data" ) )
  }
  dir.create(opt_directories()$pre_processed, recursive = TRUE, showWarnings = FALSE)

  if (is.null(opt_directories()$extracted)) {
    opt_directories( extracted = file.path( opt_directories()$raw, "..", "2.extracted.data" ) )
  }
  dir.create(opt_directories()$extracted, recursive = TRUE, showWarnings = FALSE)

  if (is.null(opt_directories()$archive)) {
    opt_directories( archive = file.path( opt_directories()$raw, "..", "3.archived.data" ) )
  }
  dir.create(opt_directories()$archive, recursive = TRUE, showWarnings = FALSE)

  if (is.null(opt_directories()$tools)) {
    opt_directories( archive = file.path( opt_directories()$raw, "..", "tools" ) )
  }
  dir.create(opt_directories()$tools, recursive = TRUE, showWarnings = FALSE)


  # Check sample_metadata.yml ----------------------------------------------


  if (!file.exists(file.path(".", opt_directories()$general.parameter, "sample_metadata.yml"))){
    stop("sample_metadata is missing")
  }

  # Load measurement packages -----------------------------------------------


  register_packages(LEEF_options$measurement_packages)


  # Load archival packages --------------------------------------------------


  register_packages(LEEF_options$archive_packages)

  # Load backend packages --------------------------------------------------


  register_packages(LEEF_options$backend_packages)


  # setup tools --------------------------------------------------------------

  LEEF.measurement.bemovi::tools_path(opt_directories()$tools)

  if (!isTRUE( suppressWarnings(LEEF.measurement.bemovi::check_tools_path(download = FALSE)) )) {
    message("d###################################################")
    message("tools directory incomplete.")
    message("downloading missing tools for bemovi...")
    message("d###################################################")
    LEEF.measurement.bemovi::check_tools_path(download = TRUE)
    message("done!")
    message("d###################################################")
  }

# Finaly the end ----------------------------------------------------------

  message("\n###################################################")
  message("## done!")
  message("###################################################")
}
