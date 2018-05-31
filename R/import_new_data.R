#' Title
#'
#'
#' @return \code{TRUE} if import succedded. If failed, report with why it failed TODO
#' @importFrom openssl sha512
#' @importFrom ROriginStamp store_hash
#' @export
#'
#' @examples
import_new_data <- function() {
  check <- new_data_ok()
  if (check$OK) {

# Create hashes of new data ---------------------------------------

    hash_new_data( tts = TRUE )

# Create archive tar ------------------------------------------------------

    tar_new_data_path()

# import new data ---------------------------------------------------------

    add_new_data()

# Delete new data files ---------------------------------------------------

    delete_new_data()

# Done --------------------------------------------------------------------

    result <- FALSE

# Finalize ----------------------------------------------------------------

  }
  return(check)
}
