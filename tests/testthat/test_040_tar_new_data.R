
# Setup -------------------------------------------------------------------

tmpdir <- file.path(tempdir(check = TRUE), "new_data_archive")
dir.create(tmpdir, showWarnings = FALSE)
file.copy(
  from = list.files(
    file.path( get_option("pkg_path"), "test_data", "new_data_archive"),
    full.names = TRUE
  ),
  to = tmpdir,
  recursive = TRUE
)
old_archive <- set_option(
  "new_data_archive",
  tmpdir
)

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

tarpath <- get_option("new_data_archive")

tarname <- paste(
  "new_data",
  format( file.mtime( file.path( get_option("new_data_dir"), "hash.sha512") ) , "%Y-%m-%d--%H-%M-%S"),
  "tar.gz",
  sep = "."
)

tarfile <- file.path(tarpath, tarname)

sha512file <-  file.path(tarpath, paste0(tarname, ".sha512") )

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
  file.path( get_option("new_data_dir"), "ref.hash.sha512"),
  file.path( get_option("new_data_dir"), "hash.sha512")
)

test_that(
  "Creates tar archive and hashes",
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
  {
    skip("I have to see if this test is usefull!")
    expect_equal(
      utils::read.table( sha512file, stringsAsFactors = FALSE )[[1]],
      utils::read.table( file.path( get_option("new_data_archive"), "ref.new_data.xxx.tar.gz.sha512" ), stringsAsFactors = FALSE )[[1]]
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
  ".sha512 file can be deleted",
  expect_error(
    unlink( sha512file ),
    regexp = NA
  )
)


# Teardown ----------------------------------------------------------------

unlink( get_option("new_data_archive"), recursive = TRUE, force = TRUE )
set_option("new_data_archive", old_archive)

unlink( get_option("new_data_dir"), recursive = TRUE, force = TRUE )
set_option("new_data_dir", old_dir)

rm( tarpath, tarname, tarfile, sha512file )


