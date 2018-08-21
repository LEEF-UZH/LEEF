#' Preprocessor flowcytometer data
#'
#' Convert all \code{.c6} files in \code{flowcytometrie} folder to \code{.fcs} files and delete \code{.c6} file..
#' @return
#'
#' @importFrom R.utils bzip2
#' @importFrom tiff readTIFF writeTIFF
#' @importFrom parallel mclapply detectCores
#' @export
#'
#' @examples
pre_processor_flowcytometer <- function(
) {
  ##
  oldwd <- getwd()
  on.exit(
    setwd(oldwd)
  )
  ##

  cat("\n########################################################\n")
  cat("\nProcessing flowcytometer...\n")
  setwd( file.path( get_option("to_be_imported"), "flowcytometer" ) )
  cmd <- "python"
  arguments <- file.path( get_option("pkg_path"), "tools", "accuri2fcs", "accuri2fcs", "accuri2fcs.py" )
  system2(
    command = cmd,
    args = arguments
  )
  unlink("*.c6")
  fcs <- list.files(
    path = file.path( get_option("to_be_imported"), "flowcytometer", "fcs" ),
    full.names = TRUE
  )
  file.rename(
    from = fcs,
    to = gsub( "/fcs/", "/", fcs )
  )
  unlink( file.path( get_option("to_be_imported"), "flowcytometer", "fcs" ), recursive = TRUE )
  cat("done\n")
  cat("\n########################################################\n")

  invisible(TRUE)
}
