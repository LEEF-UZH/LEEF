
# Setup -------------------------------------------------------------------

tmparch <- file.path(tempdir(check = TRUE), "new_data_archive")
dir.create(tmparch, showWarnings = FALSE)
old_archive <- set_option(
  "new_data_archive",
  tmparch
)

tmpnew <- file.path(tempdir(check = TRUE), "new_data")
dir.create(tmpnew, showWarnings = FALSE)
file.copy(
  from = list.files( file.path( get_option("pkg_path"), "test_data", "new_data", "false"), full.names = TRUE ),
  to = tmpnew,
  recursive = TRUE
)
old_dir <- set_option(
  "new_data_dir",
  tmpnew
)

tarpath <- get_option("new_data_archive")

tarname <- paste(
  "new_data",
  format( file.mtime( file.path( get_option("new_data_dir"), "hash.sha256") ) , "%Y-%m-%d--%H-%M-%S"),
  "tar.gz",
  sep = "."
)

tarfile <- file.path(tarpath, tarname)

sha256file <-  file.path(tarpath, paste0(tarname, ".sha256") )

# Tests -------------------------------------------------------------------

context("Test tar_new_data()")

test_that(
  "Error because no hashes calculated",
  expect_error(
    tar_new_data(),
    regexp = NULL
  )
)

file.rename(
  file.path( get_option("new_data_dir"), "ref.hash.sha256"),
  file.path( get_option("new_data_dir"), "hash.sha256")
)

test_that(
  "Creates tar archive and hashes",
  expect_error(
    tar_new_data(),
    regexp = NA
  )
)

test_that(
  "Error as tar file exists",
  expect_error(
    tar_new_data()
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
  "Created hash in .sha256 file is identical to reference",
  {
    skip("I have to see if this test is usefull!")
    expect_equal(
      utils::read.table( sha256file, stringsAsFactors = FALSE )[[1]],
      utils::read.table( file.path( get_option("new_data_archive"), "ref.new_data.xxx.tar.gz.sha256" ), stringsAsFactors = FALSE )[[1]]
    )
  }
)

test_that(
  ".tar.gz file can be deleted",
  expect_error(
    unlink( tarfile ),
    regexp = NA
  )
)

test_that(
  ".sha256 file can be deleted",
  expect_error(
    unlink( sha256file ),
    regexp = NA
  )
)


# Teardown ----------------------------------------------------------------

unlink( tmpnew, recursive = TRUE, force = TRUE )
unlink( tmparch, recursive = TRUE, force = TRUE )

set_option("new_data_archive", old_archive)
set_option("new_data_dir", old_dir)

rm( tarpath, tarname, tarfile, sha256file )


