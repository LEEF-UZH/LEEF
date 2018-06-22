#' Disconnect from connected raw data source
#'
#' @return result from \code{DBI::dbDisconnect(conn)}
#' @importFrom DBI dbDisconnect
#' @export
#'
#' @examples
db_disconnect_data <- function() {
  result <- NULL
  if (!is.null(get_option("data_connection"))) {
    try(
      result <- DBI::dbDisconnect(get_option("data_connection")),
      silent = TRUE
    )
    set_option("data_connection", NULL)
  }
  invisible(result)
}
