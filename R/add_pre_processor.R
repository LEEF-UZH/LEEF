#' @title Add or replace a function in a queue
#'
#' @details \bold{add_pre_processor}: Adding a named function to the queue of pre-processors. If the named function
#' already exists will it be replaced.
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
