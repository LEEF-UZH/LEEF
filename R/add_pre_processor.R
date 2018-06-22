#' Add or replace pre-processor
#'
#' Adding a named function to the queue of pre-processors. If the named function already exists will it be replaced.
#' @param fun function which is run during pre-processing of the data.
#'
#' @return invisiby the pre-processor queue. A \code{list} which is processed
#' @export
#'
#' @examples
add_pre_processor <- function(fun) {
  if (!is.function(fun)) {
    stop( "fun needs to be a function!")
  }
  pp <- get_option("pre_processors")
  funname <- deparse(substitute(fun))
  pp[[funname]] <- fun
  set_option(
    name = "pre_processors",
    value = pp
  )
  invisible( get_option("pre_processors") )
}
