#' Run additors queue
#'
#' Run all the additors registered with \code{add_additor()}.
#' @return
#'
#' @export
#'
#' @examples
#' \dontrun{
#' run_additors()
#' }

run_additors <- function() {

  result <- run(
    input = opt_directories()$directory$raw,
    output = opt_directories()$pre_processed,
    queue = "additors"
  )

  invisible(result)
}
