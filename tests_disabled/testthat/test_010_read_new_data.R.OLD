
# Setup -------------------------------------------------------------------

old_dir <- set_option(
  "to_be_imported",
  file.path( get_option("pkg_path"), "test_data", "new_data", "true")
)

# Tests -------------------------------------------------------------------

context("Test read_new_data()")

test_that( "Reads data correctly",
           {
             expect_equal_to_reference(
               read_new_data("fcam"),
               file.path( get_option("to_be_imported"), "fcam.rds" )
             )
           }
)


# Teardown ----------------------------------------------------------------

set_option("to_be_imported", old_dir)


