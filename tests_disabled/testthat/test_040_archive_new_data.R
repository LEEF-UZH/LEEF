context("Test archive_new_data()")

# Setup -------------------------------------------------------------------


testdir <- tempfile( pattern = "test_030_archive_new_data.")
dir.create( testdir )
file.copy(
  from = system.file("sample_data", "test_030_archive_new_data", "config.yml", package = "LEEF"),
  to = testdir
)
setwd( testdir )
initialize_db( )

file.copy(
  from = list.files( system.file( "sample_data", "test_030_archive_new_data", "ToBeImported", package = "LEEF" ), full.names = TRUE ),
  to = DATA_options( "to_be_imported" ),
  recursive = TRUE
)


# Test unsupported compression --------------------------------------------

test_that(
  "Error because unsupported compression",
  expect_error(
    archive_new_data( compression = "test"),
    regexp = NULL
  )
)


# Test hashes -------------------------------------------------------------

test_that(
  "Error because no hashes calculated",
  expect_error(
    archive_new_data(),
    regexp = NULL
  )
)

hash_new_data()


# Test compression = tar --------------------------------------------------

test_that(
  "Creates tar archive, but no tts",
  expect_error(
    archive_new_data( get_tts = FALSE ),
    regexp = NA
  )
)

test_that(
  "Correct number of files are created for tar and no tts",
  {
    expect_length(
      list.files( DATA_options("archive") ),
      2
    )
  }
)

# Delete previous archive
unlink(file.path(DATA_options("archive"), "*"), recursive = TRUE)

test_that(
  "Creates tar archive with tts",
  expect_error(
    archive_new_data( get_tts = TRUE ),
    regexp = NA
  )
)

test_that(
  "Correct number of files are created with tar and tts",
  {
    expect_length(
      list.files( DATA_options("archive") ),
      3
    )
  }
)

# Delete previous archive
unlink(file.path(DATA_options("archive"), "*"), recursive = TRUE)


# Test compression = tar.gz -----------------------------------------------

test_that(
  "Creates tar.gz archive, but no tts",
  expect_error(
    archive_new_data( compression = "tar.gz", get_tts = FALSE ),
    regexp = NA
  )
)

test_that(
  "Correct number of files are created for tar.gz but no tts",
  {
    expect_length(
      list.files( DATA_options("archive") ),
      2
    )
  }
)

# Delete previous archive
unlink(file.path(DATA_options("archive"), "*"), recursive = TRUE)

test_that(
  "Creates tar archive with tts",
  expect_error(
    archive_new_data( compression = "tar.gz", get_tts = TRUE ),
    regexp = NA
  )
)

test_that(
  "Correct number of files are created for tar.gz with tts",
  {
    expect_length(
      list.files( DATA_options("archive") ),
      3
    )
  }
)

# Delete previous archive
unlink(file.path(DATA_options("archive"), "*"), recursive = TRUE)

# Test copmpression = none ------------------------------------------------

test_that(
  "Creates none archive, but no tts",
  expect_error(
    archive_new_data( compression = "none", get_tts = FALSE ),
    regexp = NA
  )
)

test_that(
  "Correct number of files are created for none but no tts",
  {
    expect_length(
      list.files( DATA_options("archive"), recursive = TRUE ),
      29
    )
  }
)

# Delete previous archive
unlink(file.path(DATA_options("archive"), "*"), recursive = TRUE)

test_that(
  "Creates tar archive with tts",
  expect_error(
    archive_new_data( compression = "none", get_tts = TRUE ),
    regexp = NA
  )
)

test_that(
  "Correct number of files are created for none with tts",
  {
    expect_length(
      list.files( DATA_options("archive"), recursive = TRUE ),
      30
    )
  }
)

# Delete previous archive
unlink(file.path(DATA_options("archive"), "*"), recursive = TRUE)

# Teardown ----------------------------------------------------------------

unlink( testdir, recursive = TRUE, force = TRUE )


