#' @title Add or replace a function in a queue
#'
#' @details \bold{add_pre_processor}: Adding a named function to the queue of
#'   pre-processors. If the named function already exists will it be replaced.
#'
#'   This function should pre-process the raw data. The pre-processed data
#'   should be archive ready, i.e. contain the same information as the raw data,
#'   be in an open format, and be compressed if possible.
#'
#' @rdname add
#'
#' @export
#'
#' @examples
#' add_pre_processor( fun = paste )
add_pre_processor <- function(fun) {
  funname <- paste0(
    getNamespaceName(environment(fun))[[1]],
    "::",
    deparse(substitute(fun))
  )
  invisible( add(fun, funname, queue = "pre_processors") )

}
