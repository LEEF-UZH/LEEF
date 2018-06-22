#' Connect to raw data source
#'
#' The connection is saved in the option \code{data_connection}
#' @return invisibly the connection
#'
#' @importFrom DBI dbConnect
#' @export
#'
#' @examples
db_connect_data <- function() {
  if (!is.null(get_option("data_connection"))) {
    db_disconnect_data()
  }
  if (get_option("config")$data$backend$driver == "RSQLite::SQLite()") {
    if (is.null(get_option("config")$data$backend$dbpath)) {
      dbname = file.path(get_option("pkg_path"), "data", get_option("config")$data$backend$dbname)
    } else {
      dbname = file.path(get_option("config")$data$backend$dbpath, get_option("config")$data$backend$dbname)
    }
    set_option(
      "data_connection",
      DBI::dbConnect(
        drv = eval( parse( text = get_option("config")$data$backend$driver ) ),
        dbname = dbname
      )
    )
  } else {
    stop("Not Implemented yet!")
  }
  invisible(TRUE)
}
