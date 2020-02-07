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
    input = options()$LEEF.Data$directory$raw,
    output = options()$LEEF.Data$directory$pre_processed,
    queue = "additors"
  )

  invisible(result)
}
