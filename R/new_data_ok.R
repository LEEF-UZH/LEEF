#' Check new data
#'
#' Check the data in the directory \code{new_data_dir} for conformity with database rules
#'
#' @param new_data_dir directory where the new data files are located in. Defaults to \code{system.file("new_data", package = packageName())}
#' @param ... aditional arguments for the test function \code{testthat::test_dir}
#'
#' @return invisibly returns list of two elements as class \code{data_test_results}
#' \describe{
#'    \item{\code{result}:}{  \code{TRUE} if data is conform with rules, \code{FALSE} if not}
#'    \item{\code{details}:}{ obect of class \code{testthat_results} containing the detailed results of the tests}
#' }
#' @export
#' @importFrom test_dir testthat
#'
#' @examples
#'
#' # To check data in the default directory, you can use
#' new_data_ok()
#' #
#' # You can also specify a directory in which the data can be found
#' \dontrun{
#' new_data_ok("./datadir")
#' }
new_data_ok <- function(
  new_data_dir = system.file("new_data", package = packageName()),
  ...
){
  result <- list(
    result = FALSE,
    new_data_dir = new_data_dir,
    details = NA
  )
  class(result) <- "data_test_results"
  #
  options(new_data_dir = new_data_dir)
  result$details <- testthat::test_dir(
    system.file("new_data_ok", package = packageName()),
    ...
  )
  result$result <- all( !as.data.frame(result$details)$failed )
  invisible( result )
}
