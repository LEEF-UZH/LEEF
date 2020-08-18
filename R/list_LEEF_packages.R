#' List packages on which LEEF depends from the LEEF-UZH repo
#'
#' This function is a wrapper around \code{tools::package_dependencies("LEEF",
#' which = "all", recursive = TRUE)} which returns only the packages which
#' contain \bold{.LEEF} or \bold{LEEF.} and the package \bold{LEEF} itself.
#' @param recursive logical: should (reverse) dependencies of (reverse) dependencies (and so on) be included? defaults to \code{TRUE}
#'
#' @return list of all packages which are installed which contain \bold{.LEEF} or \bold{LEEF.} and the package \bold{LEEF} itself
#' @export
#' @importFrom tools package_dependencies
#'
#' @examples
#' \dontrun{
#' list_LEEF_packages()
#' }
list_LEEF_packages <- function(
  recursive = TRUE
) {
  result <- tools::package_dependencies("LEEF", which = "all", recursive = recursive)
  return(
    c(
      "LEEF",
      grep("LEEF.|.LEEF", result$LEEF, value = TRUE)
    )
  )
}
