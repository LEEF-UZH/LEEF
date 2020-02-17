#' @title Add or replace a function in a queue
#'
#' @details \bold{add_extractor}: Adding a named function to the queue of extractors. If the named function
#' already exists will it be replaced.
#'
#' @rdname add
#'
#' @export
#'
#' @examples
#' add_extractor( fun = paste )
add_extractor <- function(fun) {
  funname <- paste0(
    getNamespaceName(environment(fun))[[1]],
    "::",
    deparse(substitute(fun))
  )
  invisible( add(fun, funname, "extractors") )
}
