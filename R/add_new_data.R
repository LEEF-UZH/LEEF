#' Write a raw data table
#'
#' Add new data to the database. If a table exist, append it, if not, create a new table with the name \code{name} if \code{create_new_table = TRUE}.
#'
#' @param create_new_table if \code{TRUE}, create a new table if it does not exist. Default \code{FALSE}, i.e. raises error if the table does not exist.
#'
#' @return returns invisible\code{TRUE}
#' @importFrom DBI dbWriteTable dbExistsTable
#' @export
#'
#' @examples
add_new_data <- function(
  create_new_table = FALSE
){
on.exit(
  {
    if (closeAgain) {
      disconnect_raw_data()
    }
  }
)

# Check if connection should be closed again ------------------------------

  closeAgain <- FALSE
  if (is.null(get_option("raw_data_connection"))) {
    connect_raw_data()
    closeAgain <- TRUE
  }

# Get new_data file names, extension and path -----------------------------

  new_data_dir <-  get_option("new_data_dir")
  new_data_extension <- get_option("config")$new_data_extension
  new_files <- list.files( path = new_data_dir, pattern = new_data_extension )
  table_names <- gsub(new_data_extension, "", new_files)

  if ( !file.exists( file.path( new_data_dir, "hash.sha512") ) ) {
    stop("The new data has not been hashed - please run `hash_new_data() before running this command!")
  }


# Check if table exists ---------------------------------------------------

  for (tbl in table_names) {
    if (
      (!DBI::dbExistsTable( conn = get_option("raw_data_connection"), name = tbl ) ) &
      (!create_new_table)
    ) {
      stop("Table '", tbl, "' does not exist!", "\n", "If you want to create the table, set 'create_new_table = TRUE' when calling 'write_new_table!")
    }
  }

# Write data --------------------------------------------------------------
  timestamp <- format( file.mtime( file.path( new_data_dir, "hash.sha512") ) , "%Y-%m-%d--%H-%M-%S")
  for (i in 1:length(new_files)) {
    x <- read_new_data(new_files[i])
    x[["hash"]] <- read_new_data_hash(new_files[[i]])
    x[["timestamp"]] <- timestamp
    # TODO: CHECK IF ALREADY IMPORTED!
    DBI::dbWriteTable(
      conn = get_option("raw_data_connection"),
      name = table_names[i],
      value = x,
      overwrite = FALSE,
      append = TRUE
    )
  }

# Finalise stuff ----------------------------------------------------------

  invisible(TRUE)
}


