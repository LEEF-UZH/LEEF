#' Check new data
#'
#' ONLY DUMMY
#' Check the data in the directory \code{to_be_imported} for conformity with database rules
#'
#' @param ... aditional arguments for the test function \code{testthat::test_dir}
#'
#' @return invisibly returns list of two elements as class \code{data_test_results}
#' \describe{
#'    \item{\code{result}}{  \code{TRUE} if data is conform with rules, \code{FALSE} if not}
#'    \item{\code{details}}{ obect of class \code{testthat_results} containing the detailed results of the tests}
#' }
#' @export
#' @importFrom testthat test_dir test_that
#' @importFrom testthat  expect_named expect_gt expect_lt  expect_false expect_true
#'
#' @examples
#'
#' # To check data in the default directory, you can use
#' check_new_data()
#' #
#' # You can also specify a directory in which the data can be found
#' \dontrun{
#' check_new_data("./datadir")
#' }
check_new_data <- function(
  ...
){
  warning("Check only dummy!!!!")
  result <- TRUE
  # to_be_imported <-  DATA_options("to_be_imported")
  # ##
  # result <- list(
  #   OK = FALSE,
  #   to_be_imported = to_be_imported,
  #   details = NA
  # )
  # class(result) <- "data_test_results"
  # #
  # result$details <- testthat::test_dir(
  #   file.path( system.file(package = utils::packageName()), "check_new_data_tests"),
  #   ...
  # )
  # result$OK <- all( !as.data.frame(result$details)$failed )
  invisible( result )
}
