#' Disconnect from connected raw data source
#'
#' @return result from \code{DBI::dbDisconnect(conn)}
#' @importFrom DBI dbDisconnect
#' @export
#'
#' @examples
disconnect_raw_data <- function() {
  result <- NULL
  if (!is.null(get_option("raw_data_connection"))) {
    result <- DBI::dbDisconnect(get_option("raw_data_connection"))
    set_option("raw_data_connection", NULL)
  }
  invisible(result)
}
