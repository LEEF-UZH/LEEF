context("Test new_data_ok()")

test_that(
  "Runs without error",
  expect_error(
    set_option("tmp", new_data_ok(reporter = SilentReporter)),
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
  file.path( get_option("pkg_path"), "test_data", "true"  )
)

test_that(
  "Runs without error",
  expect_error(
    set_option("tmp", new_data_ok(reporter = SilentReporter)),
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

set_option("new_data_dir", old_dir)
