#' Run pre_processors queue
#'
#' Run all the additors registered with \code{add_pre_processor()}.
#' @return returns the results of the queue as a vector of length of the queue.
#'   If an element is \code{TRUE}, the function was run successfully (i.e.
#'   returned \code{TRUE})
#'
#' @export
#'
#' @examples
#' \dontrun{
#' run_pre_processors()
#' }

run_pre_processors <- function() {

  result <- run(
    input = opt_directories()$raw,
    output = opt_directories()$pre_processed,
    queue = "pre_processors"
  )

  invisible(result)
}
