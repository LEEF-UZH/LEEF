#' List packages on which LEEF depends
#'
#' This function is a wrapper around \code{tools::package_dependencies("LEEF", which = "all")}
#'
#' @param recursive logical: should (reverse) dependencies of (reverse) dependencies (and so on) be included?
#'
#' @return
#' @export
#' @importFrom tools package_dependencies
#'
#' @examples
#' LEEF_installed_packages()
LEEF_installed_packages <- function(
  recursive = FALSE
) {
  tools::package_dependencies("LEEF", which = "all", recursive = recursive)
}
