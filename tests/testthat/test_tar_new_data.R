context("Test tar_new_data()")

test_that(
  "Creates taqr archive and hashes",
  expect_error(
    tar_new_data(),
    regexp = NA
  )
)

test_that(
  "Created tar.gz file is identical to reference",
  expect_equal(
    tools::md5sum( tarfile    )[[1]],
    tools::md5sum( file.path( get_option("new_data_archive"), "ref.new_data.xxx.tar.gz" ) )[[1]]
  )
)

test_that(
  "Created hash in .sha512 file is identical to reference",
  expect_equal(
    read.table( sha512file, stringsAsFactors = FALSE )[[1]],
    read.table( file.path( get_option("new_data_archive"), "ref.new_data.xxx.tar.gz.sha512" ), stringsAsFactors = FALSE )[[1]]
  )
)

test_that(
  ".tar.gz file can be deleted",
  expect_error(
    unlink( tarfile ),
    regexp = NA
  )
)

test_that(
  ".sha512 file can be deleted",
  expect_error(
    unlink( sha512file ),
    regexp = NA
  )
)


