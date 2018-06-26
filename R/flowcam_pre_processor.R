#' Preprocessor flowcam data
#'
#' Convert all \code{.tif} files in \code{flowcam} folder to zip compressed TIFF.
#' @return
#'
#' @importFrom R.utils bzip2
#' @importFrom tiff readTIFF writeTIFF
#' @importFrom parallel mclapply detectCores
#' @export
#'
#' @examples
flowcam_pre_processor <- function(
) {

  cat("\n########################################################\n")
  cat("\nProcessing flowcam...\n")
  tif <- list.files(
    path = file.path( get_option("to_be_imported"), "flowcam" ),
    pattern = "*.tif",
    full.names = TRUE,
    recursive = TRUE
  )
  if ( length(tif) > 0 ) {
    parallel::mclapply(
      tif,
      function(tn){
        tiff::writeTIFF(
          what = tiff::readTIFF(tn),
          where = tn,
          compression = "deflate"
        )
      },
      mc.cores = parallel::detectCores() - 2
    )
  }
  cat("done\n")
  cat("\n########################################################\n")

  invisible(TRUE)
}
