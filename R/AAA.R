
### Called when package is loaded

# Create cache environment ------------------------------------------------

.DATA_CACHE <- new.env(FALSE, parent = globalenv())

.onLoad <- function(lib, pkg) {
  # Set fcam option ------------------------------------------------------

  set_option("fcam", NULL)

  # Set pkg_path ------------------------------------------------------------

  set_option(
    "pkg_path",
    system.file(package = packageName())
  )

  # Set Config name --------------------------------------------------------

  fn <- file.path(
    get_option("pkg_path"),
    "CONFIG.NAME"
  )
  cn <- readChar(
    fn,
    file.info(fn)$size
  )
  cn <- gsub("\n", "", cn)
  set_option(
    "config_name",
    cn
  )

  # Set Config -------------------------------------------------------------
  set_option(
    "config",
    config::get(
      config =  get_option("config_name"),
      file = file.path(
        get_option("pkg_path"),
        "./inst/config.yml"
      )
    )
  )


  # Set new_data_dir -___-------------------------------------------------------

  set_option(
    "new_data_dir",
    file.path( get_option("pkg_path"), "new_data"  )
  )

  # Set new_data_archiver -___-------------------------------------------------------

  set_option(
    "new_data_archive",
    file.path( get_option("pkg_path"), "new_data_archive"  )
  )

  # Set raw_data_connection -----------------------------------------------------
  set_option(
    "raw_data_connection",
    NULL
  )


}



