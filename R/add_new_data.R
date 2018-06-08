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
      db_disconnect_raw_data()
    }
  }
)

# Check if connection should be closed again ------------------------------

  closeAgain <- FALSE
  if (is.null(get_option("raw_data_connection"))) {
    db_connect_raw_data()
    closeAgain <- TRUE
  }

# Get new_data file names, extension and path -----------------------------

  new_data_dir <-  get_option("new_data_dir")
  new_data_extension <- get_option("config")$new_data_extension
  table_names <- list.files( path = new_data_dir, pattern = new_data_extension )
  table_names <- gsub(new_data_extension, "", table_names)

  if ( !file.exists( file.path( new_data_dir, "hash.sha256") ) ) {
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

  ####
  ## TODO
  ####
  ## Check before writing, that all hashes are new - maybe use the hash for the new_data_set?

# Write data --------------------------------------------------------------
  # timestamp <- format( file.mtime( file.path( new_data_dir, "hash.sha256") ) , "%Y-%m-%d--%H-%M-%S")
  for (i in 1:length(table_names)) {
    x <- read_new_data(table_names[i])
    x[["hash"]] <- read_new_data_hash(table_names[[i]])
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


