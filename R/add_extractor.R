#' Add or replace extractor
#'
#' Adding a named function to the queue of extractors. If the named function already exists will it be replaced.
#'
#' The functions must not require any arguments.
#' @param fun function which is run during extracting of the data.
#'
#' @return invisiby the extractor queue. A \code{list} which is processed
#' @export
#'
#' @examples
add_extractor <- function(fun) {
  if (!is.function(fun)) {
    stop( "fun needs to be a function!")
  }
  pp <- get_option("extractors")
  funname <- deparse(substitute(fun))
  pp[[funname]] <- fun
  set_option(
    name = "extractors",
    value = pp
  )
  invisible( get_option("extractors") )
}