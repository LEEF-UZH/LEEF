#' Preprocessor flowcam data
#'
#' Conversion of uncompressed TIFF to compressed TIFF.
#' @return
#'
#' @importFrom R.utils bzip2
#' @importFrom tiff readTIFF writeTIFF
#' @importFrom parallel mclapply detectCores
#' @export
#'
#' @examples
pre_process_flowcam <- function(
) {

  cat("\nProcessing flowcam...")
  tif <- list.files(
    path = file.path( get_option("to_be_imported"), "flowcam" ),
    pattern = "*.tif",
    full.names = TRUE
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
      mc.cores = parallel::detectCores() - 4
    )
  }
  cat(" done\n")

  invisible(TRUE)
}
