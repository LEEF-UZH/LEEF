#' Prepare data for import into database
#'
#' Run all the extractors registered with \code{extractors}.
#'
#' They are saved in a list in the option \code{add_extractor} and processed in order.
#' @return
#'
#' @export
#'
#' @examples
extract_new_data <- function() {

  result <- lapply(
    X = DATA_options("extractors"),
    FUN = do.call,
    list()
  )

  invisible(result)
}
