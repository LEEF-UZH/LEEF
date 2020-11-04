#' Process all ques in the correct order
#'
#' This function is an example and can be used as a template for processing the
#' queues in a script,. Raw data is always archived using the "none"
#' compression.
#' @return invisibly \code{TRUE}
#'
#' @param submitter name of submitter. When provided, will override the one in
#'   the `sample_metadata.yml` file.
#' @param timestamp timestamp for the data. When provided, will override the one in
#'   the `sample_metadata.yml` file.
#' @param process if \code{TRUE}, the pipeline will be processed. if
#'   \code{FALSE}, only the checks of the config file will be done nd no actual
#'   processing is happening.
#' @param ... additional arguments for the different queues
#'
#' @importFrom yaml yaml.load_file write_yaml
#'
#' @export
#'
#' @examples
#' \dontrun{
#'  process()
#' }

process <- function(
  submitter,
  timestamp,
  process = TRUE,
  ...
) {

  # Set sample metadata -----------------------------------------------------

  smdf <- file.path(opt_directories()$raw, "sample_metadata.yml")

  smd <- yaml::yaml.load_file(smdf)

  if (!missing(submitter)) {
    smd$submitter <- submitter
  } else if (smd$submitter == "<<TO BE ENTERED>>") {
    stop(
      "A submitter needs to be specified!\n",
      "This can be done\n",
      "  - in the 'sample_metadata.yml' file in the raw data directory or \n",
      "  - as an argument for the function 'process()'!"
    )
  }

  if (!missing(timestamp)) {
    smd$timestamp <- timestamp
  } else if (smd$timestamp == "<<TO BE ENTERED>>") {
    smd$timestamp <- format( Sys.time() , "%Y-%m-%d--%H-%M-%S" )
  }

  yaml::write_yaml(
    smd,
    smdf
  )

  # Process queues ----------------------------------------------------------
  if (process) {
    message("\n########################################################\n")
    message("\narchiving raw data ...\n")
    LEEF.archive.default::run_archive_none(
      input = getOption("LEEF")$directories$raw,
      output = file.path(getOption("LEEF")$directories$archive, "raw")
    )
    message("done\n")
    message("\n########################################################\n")

    message("\n########################################################\n")
    message("\npre_processing ...\n")
    run_pre_processors()
    message("done\n")
    message("\n########################################################\n")

    message("\n########################################################\n")
    message("\narchiving pre-processed data...\n")
    run_archivers(
      input = getOption("LEEF")$directories$pre_processed,
      output = file.path(getOption("LEEF")$directories$archive, "pre_processed")
    )
    message("done\n")
    message("\n########################################################\n")

    message("\n########################################################\n")
    message("\nextracting ...\n")
    run_extractors()
    message("done\n")
    message("\n########################################################\n")

    message("\n########################################################\n")
    message("\narchiving extracted data ...\n")
    run_archivers(
      input = getOption("LEEF")$directories$extracted,
      output = file.path(getOption("LEEF")$directories$archive, "extracted")
    )
    message("done\n")
    message("\n########################################################\n")

    message("\n########################################################\n")
    message("\nadding...\n")
    run_additors()
    message("done\n")
    message("\n########################################################\n")

  } else {
    message("\n########################################################")
    message("\nskipping processing of process(process = FALSE) command)")
    message("\n########################################################")
  }

  # Finalize ----------------------------------------------------------------

  invisible(TRUE)
  }
