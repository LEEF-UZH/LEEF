#' Process all ques in the correct order
#'
#' This function is an example and can be used as a template for processing the queues in a script
#' @return invisibly \code{TRUE}
#'
#' @param ... additional arguments for the different queues
#'
#' @export
#'
#' @examples
#' \dontrun{
#'  process()
#' }

process <- function(
  ...
) {

  message("\n########################################################\n")
  message("\npre_processing...\n")
  run_pre_processors()
  message("done\n")
  message("\n########################################################\n")

  message("\n########################################################\n")
  message("\nextracting...\n")
  run_extractors()
  message("done\n")
  message("\n########################################################\n")

  message("\n########################################################\n")
  message("\narchivingg...\n")
  run_archivers(
    input = getOption("LEEF")$directories$extracted,
    output = getOption("LEEF")$directories$archive)
  message("done\n")
  message("\n########################################################\n")

  message("\n########################################################\n")
  message("\nadding...\n")
  run_additors()
  message("done\n")
  message("\n########################################################\n")

  invisible(TRUE)
}
