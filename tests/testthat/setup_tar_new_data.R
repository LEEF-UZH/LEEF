old_archive <- set_option(
  "new_data_archive",
  file.path( get_option("pkg_path"), "test_data", "archive"  )
)
old_dir <- set_option(
  "new_data_dir",
  file.path( get_option("pkg_path"), "test_data", "for_archive"  )
)

tarpath <- get_option("new_data_archive")
tarname <- paste(
  "new_data",
  format(Sys.time(), "%Y-%m-%d"),
  "tar.gz",
  sep = "."
)
tarfile <- file.path(tarpath, tarname)

sha512file <-  file.path(tarpath, paste0(tarname, ".sha512") )
