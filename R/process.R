#' Process all ques in the correct order
#'
#' This function is an example and can be used as a template for processing the queues in a script
#' @return invisibly \code{TRUE}
#'
#' @export
#'
#' @examples
#' \dontrun{
#'  process()
#' }

process <- function(
  create_new_table = FALSE,
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
    input = options()$LEEF.Data$directories$extracted,
    output = options()$LEEF.Data$directories$archive)
  message("done\n")
  message("\n########################################################\n")

  message("\n########################################################\n")
  message("\nadding...\n")
  run_additors()
  message("done\n")
  message("\n########################################################\n")

  invisible(TRUE)
}
