#' @title Add or replace a function in a queue
#'
#' @description Functions starting with \code{add_...} do add a function to a
#'   queue which is processed by the coresponding \code{run_...} command.
#'
#'   The functions do reqquire exactly two arguments with the first named
#'   \code{input} and the second one named \code{output}. They should return
#'   either \code{TRUE} when run successful, or \code{FALSE} when failed.
#'   Although, the checking is not yet implemented.
#'
#' @details \bold{add}: The function which is doing the adding - normally the
#'   specific \code{add_*} functions are used
#'
#' @param fun function which is run when calling \code{run_...()} The functions
#'   must not require any arguments!
#' @param funname name of the function
#' @param queue name of queue in \code{getOption("LEEF")}
#'
#' @return invisibly the function queue.
#'
#' @rdname add
#'
#' @export
#'
#' @examples
#' \dontrun{
#' ## To add the function `cat` to the `additor` queue
#' add (fun = cat, .queue = "additor")
#'
#' ## To add the function `paste` to the `extractor` queue
#' add (cat, "cat", "extractor")
#' }
add <- function(
  fun,
  funname,
  queue
) {
  if (!is.function(fun)) {
    stop( "fun needs to be a function!")
  }
  ##
  LEEF_options <- getOption("LEEF")
  if (is.null(LEEF_options$queues[[queue]])) {
    LEEF_options$queues[[queue]] <- list()
  }
  LEEF_options$queues[[queue]][[funname]] <- fun
  options(LEEF = LEEF_options)
  ##
  invisible( LEEF_options$queues[[queue]] )
}
