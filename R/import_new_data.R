#' Title
#'
#'
#' @param create_new_table if \code{TRUE}, create a new table if it does not exist. Default \code{FALSE}, i.e. raises error if the table does not exist.
#' @param ... additional arguments for \code{check_new_data()}
#' @return \code{TRUE} if import succedded. If failed, report with why it failed TODO
#'
#' @importFrom openssl sha256
#' @importFrom ROriginStamp store_hash
#' @importFrom settings clone_and_merge
#'
#' @export
#'
#' @examples
import_new_data <- function(
  create_new_table = FALSE,
  ...
) {

# Prepare temp options settings for import ----------------------------------

  org_options <- settings::clone_and_merge( options = LEEF.Data:::pkg_options )

  tmproot <- tempfile( pattern = "import.")
  dir.create( tmproot )
  DATA_options(
    to_be_imported = file.path( tmproot,  "ToBeImported"),
    archive = file.path( tmproot, "Archive"),
    last_added =  file.path( tmproot, "LastAdded")
  )
  dir.create( DATA_options("archive") )
  dir.create( DATA_options("to_be_imported") )
  dir.create( DATA_options("last_added") )

# Move data into temporary folder for import and set lock file -----------
  unlink( file.path( org_options( "to_be_imported" ), "IMPORT.completed") )
  lockfile <- file.path( org_options( "to_be_imported" ), "LOCKFILE.importing" )
  on.exit(
    {
      unlink( tmproot, recursive = TRUE )
      DATA_options(
        to_be_imported = org_options( "to_be_imported" ),
        archive = org_options("archive" ),
        last_added =  org_options( "last_added")
      )
      unlink( lockfile )
    }
  )
  file.create( lockfile )
  #

  ## TODO - REPLACE WITH MOVE WHEN FINISHED DEBUGGING!!!!!!!
  file.create( file.path( org_options( "to_be_imported" ), "IMPORT.copying_to_be_imported") )
  cat("\n########################################################\n")
  cat("\nCopying new data...\n")
  file.copy(
    from = file.path( org_options("to_be_imported"), "." ),
    to = DATA_options("to_be_imported"),
    recursive = TRUE
  )
  unlink( file.path( DATA_options( "to_be_imported" ), "LOCKFILE.importing") )
  unlink( file.path( DATA_options( "to_be_imported" ), "IMPORT.copying_to_be_imported") )
  cat("done\n")
  cat("\n########################################################\n")
  #
  unlink( file.path( org_options( "to_be_imported" ), "IMPORT.copying_to_be_imported") )

# Check data, and if TRUE import ------------------------------------------

  check <- check_new_data(...)
  if (check) {

# Pre-process data --------------------------------------------------------

    file.create( file.path( org_options( "to_be_imported" ), "IMPORT.pre_process_new_data") )
    pre_process_new_data()
    unlink( file.path( org_options( "to_be_imported" ), "IMPORT.pre_process_new_data") )

# Create hashes of new data ---------------------------------------

    cat("\n########################################################\n")
    cat("\nHashing new data...\n")
    file.create( file.path( org_options( "to_be_imported" ), "IMPORT.hash_new_data") )
    hash_new_data( overwrite = FALSE )
    unlink( file.path( org_options( "to_be_imported" ), "IMPORT.hash_new_data") )
    cat("done\n")
    cat("\n########################################################\n")

# Create archive tar ------------------------------------------------------

    cat("\n########################################################\n")
    cat("\nArchiving new data...\n")
    file.create( file.path( org_options( "to_be_imported" ), "IMPORT.archive_new_data") )
    archive_file <- archive_new_data()
    unlink( file.path( org_options( "to_be_imported" ), "IMPORT.archive_new_data") )
    cat("done\n")
    cat("\n########################################################\n")

# Remove Hashes for further processing ------------------------------------

    file.create( file.path( org_options( "to_be_imported" ), "IMPORT.delete_hash_new_data") )
    delete_hash_new_data()
    unlink( file.path( org_options( "to_be_imported" ), "IMPORT.delete_hash_new_data") )

# Prepare new data for adding to database ---------------------------------

    file.create( file.path( org_options( "to_be_imported" ), "IMPORT.extract_new_data") )
    extract_new_data()
    unlink( file.path( org_options( "to_be_imported" ), "IMPORT.extract_new_data") )

# import new data ---------------------------------------------------------

    file.create( file.path( org_options( "to_be_imported" ), "IMPORT.add_new_data") )
    # add_new_data( create_new_table = create_new_table )
    unlink( file.path( org_options( "to_be_imported" ), "IMPORT.add_new_data") )

# Finalize ----------------------------------------------------------------

    file.create( file.path( org_options( "to_be_imported" ), "IMPORT.copy_archive") )
    dir.create( path = org_options("archive"), showWarnings = FALSE, recursive = TRUE )
    file.copy(
      from = file.path( DATA_options("archive"), "."),
      to = org_options("archive"),
      recursive = TRUE
    )
    unlink( file.path( org_options( "to_be_imported" ), "IMPORT.copy_archive") )
    #
    file.create( file.path( org_options( "to_be_imported" ), "IMPORT.copy_last_added") )
    dir.create( path = org_options("last_added"), showWarnings = FALSE, recursive = TRUE )
    file.copy(
      from = file.path( DATA_options("last_added"), "."),
      to = org_options("last_added"),
      recursive = TRUE
    )
    unlink( file.path( org_options( "to_be_imported" ), "IMPORT.copy_last_added") )

    file.create( file.path( org_options( "to_be_imported" ), "IMPORT.completed") )
  }
  invisible(check)
}
