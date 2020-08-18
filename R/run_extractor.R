#' Run extractors queue
#'
#' Run all the additors registered with \code{add_extractor()}.
#' @return returns the results of the queue as a vector of length of the queue.
#'   If an element is \code{TRUE}, the function was run successfully (i.e.
#'   returned \code{TRUE})
#'
#' @export
#'
#' @examples
#' \dontrun{
#' run_extractors()
#' }
run_extractors <- function() {

  result <- run(
    input = opt_directories()$pre_processed,
    output = opt_directories()$extracted,
    queue = "extractors"
  )

  invisible(result)
}
