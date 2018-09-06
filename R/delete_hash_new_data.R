#' Delete all hash files
#'
#' Deleta all \code{*.sha256} files in the \code{DATA_options("to_be_imported")} folder recursively.
#' @return invisibly the result from \code{unlink}
#' @export
#'
#' @examples
delete_hash_new_data <- function() {
  fn <- list.files(
    path = DATA_options("to_be_imported"),
    pattern = "*.sha256",
    full.names = TRUE,
    recursive = TRUE
  )
  return( unlink( fn ) )
}
