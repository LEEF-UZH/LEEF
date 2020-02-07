#' Install packages from config file and register the functions to be used
#'
#' @param list of packages. Each element \bold{must} contain the elements
#' \describe{
#'   \item{\code{name}}{the name of the package,}
#'   \item{\code{InstallCommand}}{the command to be executed to install the package, and }
#'   \item{\code{RegisterCommand}}{the command to be executed to register the functions in a queue}
#' }
#'
#' @return invisibly a list containing the results of the register commands
#' @export
#'
#' @examples
#' \dontrun{
#'  install_register_packages(options()$LEEF.Data$measurement_packages)
#' }
install_register_packages <- function(
  packages
){
  result <- lapply(
    packages,
    function(x) {
      eval(parse(text = x$InstallCommand))
      library(x$name[[1]], character.only = TRUE)
      eval(parse(text = x$RegisterCommand))
    }
  )
  invisibly(result)
}
