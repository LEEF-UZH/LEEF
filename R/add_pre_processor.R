#' Add or replace pre-processor
#'
#' Adding a named function to the queue of pre-processors. If the named function already exists will it be replaced.
#'
#' The functions must not require any arguments.
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
  pp <- DATA_options("pre_processors")
  funname <- deparse(substitute(fun))
  pp[[funname]] <- fun
  DATA_options( pre_processors = pp )
  invisible( DATA_options("pre_processors") )
}
