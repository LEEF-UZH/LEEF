#' Run pre_processors queue
#'
#' Run all the additors registered with \code{add_pre_processor()}.
#' @return returns the results of the queue as a vector of length of the queue.
#'   If an element is \code{TRUE}, the function was run successfully (i.e.
#'   returned \code{TRUE})
#'
#' @export
#'
#' @examples
#' \dontrun{
#' run_pre_processors()
#' }

run_pre_processors <- function() {

  unlink( opt_directories()$pre_processed, recursive = TRUE, force = TRUE)
  dir.create( opt_directories()$pre_processed, showWarnings = FALSE, recursive = TRUE)

  root_files <- setdiff(
    list.files(opt_directories()$raw, recursive = FALSE, full.names = FALSE),
    list.dirs(opt_directories()$raw, recursive = FALSE, full.names = FALSE)
  )
  file.copy(
    from = file.path( opt_directories()$raw, root_files),
    to   = file.path( opt_directories()$pre_processed, root_files),
    overwrite = TRUE
  )

  result <- run(
    input = opt_directories()$raw,
    output = opt_directories()$pre_processed,
    queue = "pre_processors"
  )

  invisible(result)
}
