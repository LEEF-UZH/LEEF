#' Run pre_processors queue
#'
#' Run all the additors registered with \code{add_pre_processor()}.
#' @return
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
