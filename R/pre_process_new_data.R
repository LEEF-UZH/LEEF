#' Preprocessor for the different data sources
#'
#' Run all the pre-processors registered with \code{add_pre_processor}.
#'
#' They are saved in a list in the option \code{pre_processor} and processed in order.
#' @return
#'
#' @export
#'
#' @examples
pre_process_new_data <- function() {

  result <- lapply(
    X = get_option("pre_processor"),
    FUN = do.call,
    list()
  )

  invisible(result)
}
