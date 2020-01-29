#' Preprocessor for the different data sources
#'
#' Run all the pre-processors registered with \code{add_pre_processor}.
#'
#' They are saved in a list in the option \code{pre_processors} and processed in order.
#' @return
#'
#' @export
#'
#' @examples
pre_process_new_data <- function() {

  result <- lapply(
    X = DATA_options("pre_processors"),
    FUN = do.call,
    args = list(
      input = LEEF.Data::DATA_options("to_be_imported"),
      output = LEEF.Data::DATA_options("to_be_imported")
    )
  )

  invisible(result)
}
