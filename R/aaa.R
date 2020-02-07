## .LEEF.Data_options <- new.env(FALSE, parent = globalenv())

.onAttach <- function(libname, pkgname) {

  # Load default options --------------------------------------------------

  LEEF_options <- yaml::yaml.load_file(
    system.file("default_config.yml", package = "LEEF.Data")
  )

  options(LEEF.Data = LEEF_options)
}


# LEEF_options <- function(
#   ...
# ) {
#   # protect against the use of reserved words.
#   settings::stop_if_reserved(...)
#
#   if (!missing(...)) {
#     x <- options("Leef.Data")
#
#     if ( settings::is_setting(...) ) {
#       opt = names( list(...) )
#     } else {
#       opt <- unlist( list(...) )
#     }
#     missing_options <- any(!(opt %in% names(pkg_options())))
#     if (missing_options) {
#       stop( "Option(s) not in defined options!" )
#     }
#   }
#   pkg_options(...)
#
# }
