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
    input = opt_directories()$pre_processed,
    output = opt_directories()$extracted,
    queue = "extractors"
  )

  invisible(result)
}
