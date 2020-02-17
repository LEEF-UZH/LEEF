#' @title Add or replace a function in a queue
#'
#' @details \bold{add_archiver}: Adding a named function to the queue of additors. If the named function
#' already exists will it be replaced.
#'
#' @return invisiby the function queue. A \code{list} which is processed
#'
#' @rdname add
#'
#' @export
#'
#' @examples
#' add_additor( fun = cat )
add_archiver <- function(fun) {
  funname <- paste0(
    getNamespaceName(environment(fun))[[1]],
    "::",
    deparse(substitute(fun))
  )
  invisible( add(fun, funname, "archivers") )
}
