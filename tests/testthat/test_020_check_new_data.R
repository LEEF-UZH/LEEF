
# Setup -------------------------------------------------------------------

old_dir <- set_option(
  "new_data_dir",
  file.path( get_option("pkg_path"), "test_data", "new_data", "false")
)

# Tests -------------------------------------------------------------------

context("Test check_new_data()")

test_that(
  "Runs without error",
  expect_error(
    set_option("tmp", check_new_data(reporter = SilentReporter)),
    regexp = NA
  )
)

test_that(
  "Returns data_test_results class",
  expect_s3_class(
    get_option("tmp"),
    "data_test_results"
  )
)

test_that(
  "Result is FALSE from false dataset",
  expect_false(
    get_option(("tmp"))$OK
  )
)

set_option(
  "new_data_dir",
  file.path( get_option("pkg_path"), "test_data", "new_data", "true"  )
)

test_that(
  "Runs without error",
  expect_error(
    set_option("tmp", check_new_data(reporter = SilentReporter)),
    regexp = NA
  )
)

test_that(
  "Returns data_test_results class",
  expect_s3_class(
    get_option("tmp"),
    "data_test_results"
  )
)

test_that(
  "Result is TRUE from true dataset",
  expect_true(
    get_option(("tmp"))$OK
  )
)


# teardown ----------------------------------------------------------------

set_option("new_data_dir", old_dir)
set_option("tmp", NULL)

