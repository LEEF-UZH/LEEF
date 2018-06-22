
# Setup -------------------------------------------------------------------

tmpnew <- file.path(tempdir(check = TRUE), "new_data")
unlink( tmpnew, recursive = TRUE, force = TRUE)
dir.create(tmpnew, showWarnings = FALSE)
file.copy(
  from = list.files( file.path( get_option("pkg_path"), "test_data", "new_data"), full.names = TRUE, recursive = FALSE, include.dirs = TRUE ),
  to = tmpnew,
  recursive = TRUE
)

old_dir <- set_option(
  "to_be_imported",
  file.path( tmpnew, "true")
)

tmpraw <- file.path(tempdir(check = TRUE), "data")
unlink( tmpraw, recursive = TRUE, force = TRUE)
dir.create(tmpraw, showWarnings = FALSE)
old_dir <- set_option(
  "new_raw_dir",
  tmpraw
)

# Tests -------------------------------------------------------------------

context("Test faulty import_new_data()")

old_dir <- set_option(
  "to_be_imported",
  file.path( tmpnew, "true")
)

test_that(
  "Runs without error",
  expect_error(
    set_option("tmp", import_new_data(reporter = SilentReporter)),
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
  "Result is TRUE from OK dataset",
  expect_true(
    get_option(("tmp"))$OK
  )
)

old_dir <- set_option(
  "to_be_imported",
  file.path( tmpnew, "false")
)


test_that(
  "Runs without error",
  expect_error(
    set_option("tmp",import_new_data(reporter = SilentReporter)),
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
  "Result is FALSE from faulty dataset",
  expect_false(
    get_option(("tmp"))$OK
  )
)


# teardown ----------------------------------------------------------------

unlink(tmpnew, recursive = TRUE, force = TRUE)
unlink(tmpraw, recursive = TRUE, force = TRUE)

set_option("to_be_imported", old_dir)

