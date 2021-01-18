#' Run the Control Center shiny app included in the LEEF package.
#'
#' The Control centre app allows the
#' - sanity checks of the raw data
#' - running of the pipeline
#' @md
#'
#' @param rootdir Directory in which all the data directories can be found.
#' @return return value from \code{runApp()}
#' @export
#'
#' @examples
#' \dontrun{
#' control_center()
#' }
#'
control_center <- function( rootdir = "." ) {
  if (!requireNamespace("shiny", quietly = TRUE)) {
    stop(
      "This function only works when the package `shiny` is instaled.\n",
      "To use it, please install shiny by running\n",
      "   `install.packages('shiny')`"
    )
  }
  app_dir <- system.file("app", "ControlCenter", package = "LEEF")
  if (app_dir == "") {
    stop("Could not find app directory. Try re-installing `LEEF`.", call. = FALSE)
  }

  shiny::runApp(app_dir, display.mode = "normal")
}
