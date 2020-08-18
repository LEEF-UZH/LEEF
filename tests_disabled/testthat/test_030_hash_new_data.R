context("Test hash_new_data()")

# Setup -------------------------------------------------------------------

testdir <- tempfile( pattern = "test_030_hash_new_data.")
dir.create( testdir )
file.copy(
  from = system.file("sample_data", "test_030_hash_new_data", "config.yml", package = "LEEF"),
  to = testdir
)
setwd( testdir )
initialize_db( )

# Test --------------------------------------------------------------------

test_that(
  "Returns TRUE if no files present",
  expect_true(
    hash_new_data()
  )
)

file.copy(
  from = list.files( system.file( "sample_data", "test_030_hash_new_data", "ToBeImported", package = "LEEF" ), full.names = TRUE ),
  to = DATA_options( "to_be_imported" ),
  recursive = TRUE
)

test_that(
  "Creates Hashes correctly with default values",
  expect_true(
    hash_new_data()
  )
)

test_that(
  "Error if hashes exist with default (i.e. overwrite = FALSE)",
  expect_error(
    hash_new_data()
  )
)

test_that(
  "Success if hashes exist with default overwrite = TRUE",
  expect_true(
    hash_new_data( overwrite = TRUE)
  )
)

test_that(
  "Created hash dir.sha256 is identical to expected",
  expect_equal(
    tools::md5sum( file.path( DATA_options("to_be_imported"), "dir.sha256"     ) )[[1]],
    "124c9695a06de34f6b145f74607430eb"
  )
)

test_that(
  "hash.sha265 file can be deleted",
  expect_error(
    delete_hash_new_data(),
    regexp = NA
  )
)

# Teardown ----------------------------------------------------------------

unlink( testdir, recursive = TRUE, force = TRUE )
