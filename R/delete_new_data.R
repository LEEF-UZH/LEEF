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
  stop( "TODO to be implemented!" )
  to_be_imported <-  get_option("to_be_imported")
  new_data_extension <- get_option("config")$new_data_extension
  new_files <- list.files( path = to_be_imported, pattern = new_data_extension )
  ##
  if (all) {
    result <- unlink( file.path(to_be_imported, "*") )
  } else {
    result <- unlink( file.path(to_be_imported, c(new_files, "hash.sha256", "TTS.yml") ) )
  }
  ##
  invisible(result)
}
