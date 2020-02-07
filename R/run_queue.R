#' Run process queue
#'
#' Run all the functions in the process queue named \code{queue}
#'
#' @param input directory containing the input data in folders with the name
#'   of the methodology (e.g. \code{bemovi})
#' @param output directory in which the results will be written in a folder with
#'   the name of the methodology (e.g. \code{bemovi})
#' @param queue name of queue in \code{options()$LEEF.Data}
#'
#' @return returns the results of the queue as a vector of length of the queue.
#'   If an element is \code{TRUE}, the function was run successfully (i.e.
#'   returned \code{TRUE})
#'
#' @export
#'
#' @examples
#' \dontrun{
#' run(
#'   input = "./input",
#'   output = "./output",
#'   queue = "extractor"
#' )
#' }
run <- function(
  input,
  output,
  queue
) {

  result <- lapply(
    X = options()$LEEF.Data[[queue]],
    FUN = do.call,
    args = list(
      input = input,
      output = output
    )
  )

  invisible(result)
}
