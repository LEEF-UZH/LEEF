
# Setup -------------------------------------------------------------------

tmpdir <- file.path(tempdir(check = TRUE), "new_data")
dir.create(tmpdir, showWarnings = FALSE)
file.copy(
  from = list.files( file.path( get_option("pkg_path"), "test_data", "new_data", "false"), full.names = TRUE ),
  to = tmpdir,
  recursive = TRUE
)

old_dir <- set_option(
  "new_data_dir",
  tmpdir
)

# Test --------------------------------------------------------------------

context("Test hash_new_data()")

test_that(
  "Creates Hashes correctly with default (i.e. tts = FALSE)",
  expect_error(
    hash_new_data(),
    regexp = NA
  )
)

test_that(
  "Abort if hashes exist with default (i.e. overwrite = FALSE)",
  expect_error(
    hash_new_data()
  )
)

test_that(
  "Abort if hashes exist with default (i.e. overwrite = TRUE)",
  expect_error(
    hash_new_data( overwrite = TRUE),
    regexp = NA
  )
)

test_that(
  "Created hash file is identical to reference",
  expect_equal(
    tools::md5sum( file.path( get_option("new_data_dir"), "hash.sha512"     ) )[[1]],
    tools::md5sum( file.path( get_option("new_data_dir"), "ref.hash.sha512" ) )[[1]]
  )
)

test_that(
  "hash.sha512 file can be deleted",
  expect_error(
    unlink( file.path( get_option("new_data_dir"), "hash.sha512") ),
    regexp = NA
  )
)

# tts = TRUE --------------------------------------------------------------
context("Test hash_new_data( tts = TRUE)")

test_that(
  "Creates Hashes correctly with tts = TRUE, i.e. aborts with error message",
  expect_error(
    hash_new_data(tts = TRUE),
    regexp = NULL
  )
)

test_that(
  "hash.sha512 file can be deleted",
  expect_error(
    unlink( file.path( get_option("new_data_dir"), "hash.sha512") ),
    regexp = NA
  )
)

# Teardown ----------------------------------------------------------------

unlink(tmpdir, recursive = TRUE, force = TRUE)
set_option("new_data_dir", old_dir)


