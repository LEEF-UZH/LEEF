#' @title Add or replace a function in a queue
#'
#' @description Functions starting with \code{add_...} do add a function to a queue which is
#' processed by the coresponding \code{run_...} command.
#'
#' @details \bold{add_additor}: Adding a named function to the queue of additors. If the named function
#' already exists will it be replaced.
#'
#' @param fun function which is run when calling \code{run_...()} The functions must not require any arguments!
#' @param queue name of queue in \code{options()$LEEF.Data}
#'
#' @return invisiby the function queue.
#'
#' @rdname add
#'
#' @export
#'
#' @examples
#' ## To add the function `cat` to the `additor` queue
#' add (fun = cat, .queue = "additor")
#'
#' ## To add the function `paste` to the `extractor` queue
#' add (cat, "extractor")
#'
add <- function(
  fun,
  queue
) {
  if (!is.function(fun)) {
    stop( "fun needs to be a function!")
  }
  funname <- paste0(
    getNamespaceName(environment(fun))[[1]],
    "::",
    deparse(substitute(fun))
  )
  ##
  LEEF_options <- options()$LEEF.Data
  if (is.null(LEEF_options$queue[[queue]])) {
    LEEF_options$queue[[queue]] <- list()
  }
  LEEF_options$queue[[queue]][[funname]] <- fun
  options(LEEF.Data = LEEF_options)
  ##
  invisible(  )
}
