pkg_options <- settings::options_manager(
  config_name = character(0),
  description = character(0),
  maintainer = character(0),
  # Directories
  root_dir = character(0),
  to_be_imported = character(0),
  last_added = character(0),
  archive = character(0),
  # Archive config
  archive_name = character(0),
  archive_compression = character(0),
  # TTS and DOI
  tts = character(0),
  tts_info = list(),
  doi = logical(0),
  # Database
  database = list(),
  data_connection = character(0),
  # Processors and hooks
  pre_processors = list(),
  extractors = list(),
  db_additors = list(),
  # for temporary storage
  tmp = NULL
)

#' Set or get options for this package
#'
#' @param ... Option names to retrieve option values or \code{[key]=[value]} pairs to set options.
#'
#' @section Supported options:
#' The following options are supported TODO
#' \itemize{
#'  \item{\code{api_url}} {(\code{character} = \code{"https://api.originstamp.org/api/"}) The url of the OriginStamp API }
#'  \item{\code{api_key}} {(\code{numeric} = \code{"Please get valid API key from Originstamp.org!"}) The api key.  This needs to be obtained from \url{https://originstamp.org/} }
#' }
#'
#' @importFrom settings stop_if_reserved is_setting
#' @examples
#' @export
DATA_options <- function(...){
  # protect against the use of reserved words.
  settings::stop_if_reserved(...)

  if (!missing(...)) {
    if ( settings::is_setting(...) ) {
      opt = names( list(...) )
    } else {
      opt <- unlist( list(...) )
    }
    missing_options <- any(!(opt %in% names(pkg_options())))
    if (missing_options) {
      stop( "Option(s) not in defined options!" )
    }
  }
  pkg_options(...)
}
