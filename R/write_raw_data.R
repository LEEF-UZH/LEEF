#' Write a raw data table
#'
#' Write \code{x} to a table in the database. If the table exist, append it, if not, create a new table with the name \code{name}.
#' @param name name of table in database
#' @param value tabel to be written to database
#'
#' @return returns invisible the rerturn valuer of \code{DBI::WriteTable()}
#' @importFrom DBI dbWriteTable
#' @export
#'
#' @examples
write_raw_data <- function(name, value){
  closeAgain <- FALSE
  if (is.null(get_option("raw_data_connection"))) {
    connect_raw_data()
    closeAgain <- TRUE
  }
  result <- DBI::dbWriteTable(
    get_option("raw_data_connection"),
    name = name,
    value = as.data.frame(value),
    overwrite = FALSE,
    append = TRUE
  )
  if (closeAgain) {
    disconnect_raw_data()
  }
  invisible()
}
