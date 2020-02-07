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
    input = options()$LEEF.Data$directory$raw,
    output = options()$LEEF.Data$directory$pre_processed,
    queue = "pre_processors"
  )

  invisible(result)
}
