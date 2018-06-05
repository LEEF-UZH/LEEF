#' Connect to raw data source
#'
#' The connection is saved in the option \code{raw_data_connection}
#' @return invisibly the connection
#'
#' @importFrom DBI dbConnect
#' @export
#'
#' @examples
db_connect_raw_data <- function() {
  if (!is.null(get_option("raw_data_connection"))) {
    db_disconnect_raw_data()
  }
  if (get_option("config")$data$backend$driver == "RSQLite::SQLite()") {
    if (is.null(get_option("config")$data$backend$dbpath)) {
      dbname = file.path(get_option("pkg_path"), "raw_data", get_option("config")$data$backend$dbname)
    } else {
      dbname = file.path(get_option("config")$data$backend$dbpath, get_option("config")$data$backend$dbname)
    }
    set_option(
      "raw_data_connection",
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
