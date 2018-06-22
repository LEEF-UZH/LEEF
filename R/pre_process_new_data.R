#' Preprocessor for the different data sources
#'
#' Is used for example for conversion of uncompressed TIFF to compressed TIFF. Is executed \bold{before} hashing and archiving and after checking!.
#' @return
#'
#' @importFrom R.utils bzip2
#' @importFrom tiff readTIFF writeTIFF
#' @importFrom parallel mclapply detectCores
#' @export
#'
#' @examples
pre_process_new_data <- function(
) {

# bemovi  -----------------------------------------------------------------

  # cat("\nProcessing bemovi...")
  # cxd <- list.files(
  #   path = file.path( get_option("to_be_imported"), "bemovi" ),
  #   pattern = "*",
  #   full.names = TRUE
  # )
  # if (length(cxd) > 0) {
  #   R.utils::bzip2( cxd, remove = TRUE )
  # }
  # cat("done\n")

# flowcam -----------------------------------------------------------------

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
      mc.cores = parallel::detectCores() - 2
    )
  }
  cat(" done\n")

# flowcytometer -----------------------------------------------------------


# incubatortemp -----------------------------------------------------------


# manualcounting ----------------------------------------------------------


# respirometer ------------------------------------------------------------


  invisible(FALSE)
}
