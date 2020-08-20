#' Run additors queue
#'
#' Run all the additors registered with \code{add_additor()}.
#' @return returns the results of the queue as a vector of length of the queue.
#'   If an element is \code{TRUE}, the function was run successfully (i.e.
#'   returned \code{TRUE})
#'
#' @export
#'
#' @examples
#' \dontrun{
#' run_additors()
#' }

run_additors <- function() {

  result <- run(
    input = opt_directories()$extracted,
    output = opt_directories()$backend,
    queue = "additors"
  )

  invisible(result)
}
