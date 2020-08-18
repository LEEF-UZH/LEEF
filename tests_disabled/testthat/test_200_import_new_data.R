context("Test import_new_data()")

# Setup -------------------------------------------------------------------

testdir <- tempfile( pattern = "test_200_import_new_data.")
dir.create( testdir )
file.copy(
  from = system.file( "sample_data", "test_200_import_new_data", "config.yml", package = "LEEF" ),
  to = testdir
)
setwd( testdir )
initialize_db( )

file.copy(
  from = list.files( system.file( "sample_data", "test_200_import_new_data", "ToBeImported", package = "LEEF" ), full.names = TRUE ),
  to = DATA_options( "to_be_imported" ),
  recursive = TRUE
)

# Test import_new_data ----------------------------------------------------

test_that(
  "Returns TRUE if no files present",
  expect_error(
    import_new_data(),
    regexp = NA
  )
)

# Teardown ----------------------------------------------------------------

unlink( testdir, recursive = TRUE, force = TRUE )
