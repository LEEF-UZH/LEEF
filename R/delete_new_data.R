#' Delete new data
#'
#' @param all if \code{TRUE}, delete \bold{all} files from the
#'
#' @return invisibly the result from \code{unlink(...)}
#' @export
#'
#' @examples
delete_new_data <- function(
  all = FALSE
){
  new_data_dir <-  get_option("new_data_dir")
  new_data_extension <- get_option("config")$new_data_extension
  new_files <- list.files( path = new_data_dir, pattern = new_data_extension )
  ##
  if (all) {
    result <- unlink( file.path(new_data_dir, "*") )
  } else {
    result <- unlink( file.path(new_data_dir, c(new_files, "hash.sha256", "TTS.yml") ) )
  }
  ##
  invisible(result)
}
