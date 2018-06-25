#' Title
#'
#'
#' @param create_new_table if \code{TRUE}, create a new table if it does not exist. Default \code{FALSE}, i.e. raises error if the table does not exist.
#' @param ... additional arguments for \code{check_new_data()}
#' @return \code{TRUE} if import succedded. If failed, report with why it failed TODO
#'
#' @importFrom openssl sha256
#' @importFrom ROriginStamp store_hash
#'
#' @export
#'
#' @examples
import_new_data <- function(
  create_new_table = FALSE,
  ...
) {

  check <- check_new_data(...)
  if (check$OK) {


# Pre-process data --------------------------------------------------------

    pre_process_new_data()

# Create hashes of new data ---------------------------------------

    hash_new_data( tts = FALSE, overwrite = FALSE )

# Create archive tar ------------------------------------------------------

    tryCatch(
      archive <- archive_new_data( ),
      error = function(e) {
        hf <- list.files(
          path = get_option("to_be_imported"),
          recursive = TRUE, pattern = "*.sha256",
          full.names = TRUE
        )
        unlink( hf )
        print("Error in archive_new_data - hashes deleted!")
        stop( e )
      }
    )

# Remove Hashes for further processing ------------------------------------

delete_hash_new_data()

# Prepare new data for adding to database ---------------------------------

    if (!extract_new_data()) {
      hf <- c(
        list.files(
          path = get_option("to_be_imported"),
          recursive = TRUE, pattern = "*.sha256",
          full.names = TRUE
        ),
        archive,
        paste0(archive, ".sha256")
      )
      unlink( hf )
      stop("There was an error in preparing the data for the import into the database!\n\nImport aborted and created files deleted!")
    }

# import new data ---------------------------------------------------------

    add_new_data( create_new_table = create_new_table )

# Delete new data files ---------------------------------------------------

    delete_new_data()

# Finalize ----------------------------------------------------------------

  }
  invisible(check)
}
