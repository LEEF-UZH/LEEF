#' Preprocessor bemovi data
#'
#' convert all \code{.cxd} files in \code{bemovi} folder to non-proprietory avi format and delete \code{.cxd} file.
#' @return
#'
#' @importFrom R.utils bzip2
#' @export
#'
#' @examples
pre_process_bemovi <- function(
) {
  cat("\n########################################################\n")
  cat("\nProcessing bemovi...\n")
  cxd <- list.files(
    path = file.path( get_option("to_be_imported"), "bemovi" ),
    pattern = "*.cxd",
    full.names = TRUE
  )
  for (fn in cxd) {
    cmd <- file.path( get_option("pkg_path"), "tools", "bftools", "bfconvert" )
    arguments = paste(
      "-overwrite",
      "-no-upgrade",
      fn,
      gsub(".cxd", ".avi", fn),
      sep = " "
    )
    system2(
      command = cmd,
      args = arguments
    )
    unlink(fn)
  }
  cat("done\n")
  cat("\n########################################################\n")

  invisible(TRUE)
}
