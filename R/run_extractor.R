#' Run extractors queue
#'
#' Run all the additors registered with \code{add_extractor()}.
#' @return
#'
#' @export
#'
#' @examples
#' \dontrun{
#' run_extractors()
#' }
run_extractors <- function() {

  result <- run(
    input = options()$LEEF.Data$directory$pre_processed,
    output = options()$LEEF.Data$directory$extracted,
    queue = "extractors"
  )

  invisible(result)
}
