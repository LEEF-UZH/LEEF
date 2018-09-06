
# Setup -------------------------------------------------------------------

testdir <- tempfile( pattern = "test_001_options.")
dir.create( testdir )
file.copy(
  from = system.file("sample_data", "test_001_options", "config.yml", package = "LEEF.Data"),
  to = testdir
)
setwd( testdir )
initialize_db( )

# Tests -------------------------------------------------------------------

context("Test Options")

test_that( "TRUE if option exists",
           {
             expect_error(
               DATA_options("config_name"),
               regexp = NA
             )
           }
)

test_that( "Error if option does not exists",
           {
             expect_error(
               DATA_options("some_nonsense")
             )
           }
)

test_that( "DATA_options returns correct value",
           {
             expect_equal(
               DATA_options("config_name"),
               "LEEFData"
             )
           }
)


test_that( "Set option raises error if option does not exist",
           {
             expect_error(
               DATA_options( some_nonsense = "nothing" )
             )
           }
)

# Teardown ----------------------------------------------------------------

unlink( testdir, recursive = TRUE, force = TRUE )


