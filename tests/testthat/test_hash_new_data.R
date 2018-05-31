context("Test hash_new_data()")

old_dir <- set_option(
  "new_data_dir",
  file.path( get_option("pkg_path"), "test_data", "false"  )
)

test_that(
  "Creates Hashes correctly with default (i.e. tts = FALSE)",
  expect_error(
    hash_new_data(),
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
  "Creates Hashes correctly with default (i.e. tts = FALSE), i.e. aborts with error message",
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

set_option("new_data_dir", old_dir)
