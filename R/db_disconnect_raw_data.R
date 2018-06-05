#' Disconnect from connected raw data source
#'
#' @return result from \code{DBI::dbDisconnect(conn)}
#' @importFrom DBI dbDisconnect
#' @export
#'
#' @examples
db_disconnect_raw_data <- function() {
  result <- NULL
  if (!is.null(get_option("raw_data_connection"))) {
    try(
      result <- DBI::dbDisconnect(get_option("raw_data_connection")),
      silent = TRUE
    )
    set_option("raw_data_connection", NULL)
  }
  invisible(result)
}
