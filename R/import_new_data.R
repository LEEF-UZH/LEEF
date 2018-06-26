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
  # Move data into temporary folder for impoirt and set lock file -----------
  unlink( file.path( get_option( "to_be_imported" ), "IMPORT.completed") )
  lockfile <- file.path( get_option( "to_be_imported" ), "LOCKFILE.importing" )
  set_option( "to_be_imported_org", get_option("to_be_imported") )
  set_option( "archive_org", get_option("archive") )
  set_option( "to_be_added_org", get_option("to_be_added") )
  on.exit(
    {
      set_option( "to_be_imported", get_option("to_be_imported_org") )
      set_option( "to_be_imported_org", NULL )
      #
      set_option( "to_be_added", get_option("to_be_added_org") )
      set_option( "to_be_added_org", NULL )
      #
      set_option( "archive", get_option("archive_org") )
      set_option( "archive_org", NULL )
      #
      unlink( lockfile )
    }
  )
  file.create( lockfile )
  #
  set_option( "archive", paste0( tempfile( pattern = "Archive.") ) )
  dir.create( get_option("archive") )
  #
  set_option( "to_be_imported", paste0( tempfile( pattern = "ToBeImported.")  ) )
  dir.create( get_option("to_be_imported") )
  #
  set_option( "to_be_added", paste0( tempfile( pattern = "ToBeAdded.")  ) )
  dir.create( get_option("to_be_added") )
  ## TODO - REPLACE WITH MOVE WHEN FINISHED DEBUGGING!!!!!!!
  file.create( file.path( get_option( "to_be_imported_org" ), "IMPORT.copying_to_be_imported") )
  file.copy(
    from = file.path( get_option("to_be_imported_org"), "." ),
    to = get_option("to_be_imported"),
    recursive = TRUE
  )
  unlink( file.path( get_option( "to_be_imported" ), "IMPORT.copying_to_be_imported") )
  unlink( file.path( get_option( "to_be_imported" ), "LOCKFILE.importing") )
  #
  unlink( file.path( get_option( "to_be_imported_org" ), "IMPORT.copying_to_be_imported") )

# Check data, and if TRUE import ------------------------------------------

  check <- check_new_data(...)
  if (check) {

# Pre-process data --------------------------------------------------------

    file.create( file.path( get_option( "to_be_imported_org" ), "IMPORT.pre_process_new_data") )
    pre_process_new_data()
    unlink( file.path( get_option( "to_be_imported_org" ), "IMPORT.pre_process_new_data") )

# Create hashes of new data ---------------------------------------

    file.create( file.path( get_option( "to_be_imported_org" ), "IMPORT.hash_new_data") )
    hash_new_data( tts = FALSE, overwrite = FALSE )
    unlink( file.path( get_option( "to_be_imported_org" ), "IMPORT.hash_new_data") )

# Create archive tar ------------------------------------------------------

    file.create( file.path( get_option( "to_be_imported_org" ), "IMPORT.archive_new_data") )
    archive_new_data()
    unlink( file.path( get_option( "to_be_imported_org" ), "IMPORT.archive_new_data") )

# Remove Hashes for further processing ------------------------------------

    file.create( file.path( get_option( "to_be_imported_org" ), "IMPORT.delete_hash_new_data") )
    delete_hash_new_data()
    unlink( file.path( get_option( "to_be_imported_org" ), "IMPORT.delete_hash_new_data") )

# Prepare new data for adding to database ---------------------------------

    file.create( file.path( get_option( "to_be_imported_org" ), "IMPORT.extract_new_data") )
    extract_new_data()
    unlink( file.path( get_option( "to_be_imported_org" ), "IMPORT.extract_new_data") )

# import new data ---------------------------------------------------------

    file.create( file.path( get_option( "to_be_imported_org" ), "IMPORT.add_new_data") )
    # add_new_data( create_new_table = create_new_table )
    unlink( file.path( get_option( "to_be_imported_org" ), "IMPORT.add_new_data") )

# Finalize ----------------------------------------------------------------

    file.create( file.path( get_option( "to_be_imported_org" ), "IMPORT.copy_archive") )
    file.copy(
      from = file.path( get_option("archive"), "."),
      to = get_option("archive_org"),
      recursive = TRUE
    )
    unlink( file.path( get_option( "to_be_imported_org" ), "IMPORT.copy_archive") )

    file.create( file.path( get_option( "to_be_imported_org" ), "IMPORT.copy_to_be_added") )
    file.copy(
      from = file.path( get_option("to_be_added"), "."),
      to = get_option("to_be_added_org"),
      recursive = TRUE
    )
    unlink( file.path( get_option( "to_be_imported_org" ), "IMPORT.copy_to_be_added") )

    file.create( file.path( get_option( "to_be_imported_org" ), "IMPORT.completed") )
  }
  invisible(check)
}
