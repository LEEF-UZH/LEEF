#' List packages on which LEEF depends from the LEEF-UZH repo
#'
#' This function is a wrapper around \code{tools::package_dependencies("LEEF",
#' which = "all", recursive = TRUE)} which returns only the packages which
#' contain \bold{.LEEF} or \bold{LEEF.} and the package \bold{LEEF} itself.
#' @param recursive logical: should (reverse) dependencies of (reverse) dependencies (and so on) be included? defaults to \code{TRUE}
#' @param versions logical: should versions be returned as well.
#'
#' @return list of all packages which are installed which contain \bold{.LEEF} or \bold{LEEF.} and the package \bold{LEEF} itself
#' @export
#' @importFrom tools package_dependencies
#' @importFrom drat addRepo
#'
#' @examples
#' \dontrun{
#' list_LEEF_packages()
#' }
list_LEEF_packages <- function(
  recursive = TRUE,
  versions = FALSE
) {
  drat::addRepo("LEEF-UZH")
  result <- tools::package_dependencies("LEEF", which = "all", recursive = recursive)
  pkgs <- c(
    "LEEF",
    grep("LEEF.|.LEEF", result$LEEF, value = TRUE)
  )

  if (versions) {
    pkgs <- as.vector(
      sapply(
        pkgs,
        function(x) {
          paste0(x, ": ", packageVersion(x))
        }
      )
    )
  }
  return(
  )
}
