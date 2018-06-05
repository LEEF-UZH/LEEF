
# Setup -------------------------------------------------------------------

old_dir <- set_option(
  "new_data_dir",
  file.path( get_option("pkg_path"), "test_data", "new_data", "true")
)

# Tests -------------------------------------------------------------------

context("Test read_new_data()")

test_that( "Reads data correctly",
           {
             expect_equal_to_reference(
               read_new_data("fcam.csv"),
               file.path( get_option("new_data_dir"), "fcam.rds" )
             )
           }
)


# Teardown ----------------------------------------------------------------

set_option("new_data_dir", old_dir)


