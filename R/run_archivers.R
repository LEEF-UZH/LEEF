#' Run archivers queue
#'
#' Run all the archivers registered with \code{add_archiver()}.
#'
#' @param input directory to be archive, including subdirectories
#' @param output director in which the archive will be created
#'
#' @return
#'
#' @export
#'
#' @examples
#' \dontrun{
#' run_archivers(
#'   input = "./input",
#'   output = "./output"
#' )
#' }
run_archivers <- function(
  input,
  output
) {

  result <- run(
    input = input,
    output = output,
    queue = "archivers"
  )

  invisible(result)
}
