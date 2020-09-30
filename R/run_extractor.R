#' Run extractors queue
#'
#' Run all the additors registered with \code{add_extractor()}.
#' @return returns the results of the queue as a vector of length of the queue.
#'   If an element is \code{TRUE}, the function was run successfully (i.e.
#'   returned \code{TRUE})
#'
#' @export
#'
#' @examples
#' \dontrun{
#' run_extractors()
#' }
run_extractors <- function() {

  if ( Sys.info()['sysname'] != "Linux" ){
    unlink( opt_directories()$extracted, recursive = TRUE, force = TRUE)
  }

  dir.create( opt_directories()$extracted, showWarnings = FALSE, recursive = TRUE)

  root_files <- setdiff(
    list.files(opt_directories()$pre_processed, recursive = FALSE, full.names = FALSE),
    list.dirs(opt_directories()$pre_processed, recursive = FALSE, full.names = FALSE)
  )
  file.copy(
    from = file.path( opt_directories()$pre_processed, root_files),
    to   = file.path( opt_directories()$extracted, root_files),
    overwrite = TRUE
  )

  result <- run(
    input = opt_directories()$pre_processed,
    output = opt_directories()$extracted,
    queue = "extractors"
  )

  invisible(result)
}
