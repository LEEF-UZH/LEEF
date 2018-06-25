
### Called when package is loaded

# Create cache environment ------------------------------------------------

.DATA_CACHE <- new.env(FALSE, parent = globalenv())

.onLoad <- function(lib, pkg) {
  # Set fcam option ------------------------------------------------------

  set_option("fcam", NULL)

  # Set pkg_path ------------------------------------------------------------

  set_option(
    "pkg_path",
    system.file(package = utils::packageName())
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

  # Set to_be_imported -----------------------------------------------------------

  set_option(
    "to_be_imported",
    file.path( getwd(), "ToBeImported"  )
  )

  # Set archive -----------------------------------------------------------

  set_option(
    "archive",
    file.path( getwd(), "Archive"  )
  )

  # Set data_connection -----------------------------------------------------
  set_option(
    "data_connection",
    NULL
  )


# Set archive name --------------------------------------------------------

  set_option(
    "archive_name",
    "LEEF"
  )



# Add preprocessors -------------------------------------------------------

  set_option(
    "pre_processors",
    list()
  )

  add_pre_processor( bemovi_pre_processor )
  add_pre_processor( flowcam_pre_processor )
  add_pre_processor( flowcytometer_pre_processor )

# Add Extractors ----------------------------------------------------------

  set_option(
    "extractors",
    list()
  )

  # add_pre_processor( bemovi_extractor )
  # add_pre_processor( flowcam_extractor)
  add_extractor( flowcytometer_extractor )

# And the end -------------------------------------------------------------

}


