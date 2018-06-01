#' Title
#'
#'
#' @param create_new_table if \code{TRUE}, create a new table if it does not exist. Default \code{FALSE}, i.e. raises error if the table does not exist.
#'
#' @return \code{TRUE} if import succedded. If failed, report with why it failed TODO
#' @importFrom openssl sha512
#' @importFrom ROriginStamp store_hash
#' @export
#'
#' @examples
import_new_data <- function(
  create_new_table = FALSE
) {
  check <- check_new_data()
  if (check$OK) {

# Create hashes of new data ---------------------------------------

    hash_new_data( tts = FALSE, overwrite = FALSE )

# Create archive tar ------------------------------------------------------

    tar_new_data()

# import new data ---------------------------------------------------------

    add_new_data( create_new_table = create_new_table )

# Delete new data files ---------------------------------------------------

    delete_new_data()

# Finalize ----------------------------------------------------------------

  }
  invisible(check)
}
