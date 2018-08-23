#' Create folder structure for data import and processing
#'
#' @return invisible \code{TRUE}
#' @importFrom magrittr %>%
#' @export
#'
#' @examples
initialize_db <- function(){

  # Load Config -------------------------------------------------------------

  set_option(
    "config",
    config::get(
      file = file.path( getwd(), "config.yml" )
    )
  )


  # Set Config name --------------------------------------------------------

  set_option(
    "config_name",
    get_option("config")$configname
  )


  # Set to_be_imported -----------------------------------------------------------

  set_option(
    "to_be_imported",
    file.path( getwd(), "ToBeImported" )
  )

  # Set last_added name --------------------------------------------------------

  set_option(
    "last_added",
    file.path( getwd(), "LastAdded" )
  )

  # Set archive -----------------------------------------------------------

  set_option(
    "archive",
    file.path( getwd(), "Archive"  )
  )

  # Set archive name --------------------------------------------------------

  set_option(
    "archive_name",
    "LEEF"
  )

  # Set data_connection -----------------------------------------------------

  set_option(
    "data_connection",
    NULL
  )

  # Add preprocessors -------------------------------------------------------

  set_option(
    "pre_processors",
    list()
  )

  add_pre_processor( pre_processor_flowcam )
  add_pre_processor( pre_processor_flowcytometer )
  add_pre_processor( pre_processor_bemovi )

  # Add Extractors ----------------------------------------------------------

  set_option(
    "extractors",
    list()
  )

  # add_pre_processor( bemovi )
  add_extractor( extractor_flowcam )
  add_extractor( extractor_incubatortemp )
  add_extractor( extractor_flowcytometer )
  add_extractor( extractor_manualcount )
  add_extractor( extractor_respirometer )
  add_extractor( extractor_bemovi )

  # And the end -------------------------------------------------------------



# ToBeImported folder structure -------------------------------------------

  dir.create( get_option("to_be_imported"), showWarnings = FALSE )
  sources <- c(
    get_option("pre_processors") %>% names() %>% gsub("pre_processor_", "", .),
    get_option("extractors") %>% names() %>% gsub("extractor_", "", .)
  ) %>% unique()
  for (d in sources) {
    dir.create( file.path(get_option("to_be_imported"), d), showWarnings = FALSE )
  }

# Archive folder structure ------------------------------------------------

  dir.create( get_option("archive"), showWarnings = FALSE )

# LastAdded folder structure ----------------------------------------------

  dir.create( get_option("last_added"), showWarnings = FALSE )

# DB folder structure -----------------------------------------------------

  ## dir.create( get_option("last_added"), showWarnings = FALSE )
  cfg <- get_option("config")
  if (is.null(cfg$data$backend$dbpath)) {
    cfg$data$backend$dbpath <- file.path( getwd(), "DB" )
    set_option("config", cfg)
  }
  dir.create( get_option("config")$data$backend$dbpath, showWarnings = FALSE )
  file.create( file.path( get_option("config")$data$backend$dbpath, get_option("config")$data$backend$dbname ) )
}
