#' Register the functions to be usedfrom packages in the config file
#' @param packages of packages. Each element \bold{must} contain the elements
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
#'  register_packages(getOption("LEEF")$measurement_packages)
#' }
register_packages <- function(
  packages
){
  result <- lapply(
    packages,
    function(x) {
      message("\n")
      message("###################################################")
      message("##### Registering ", x$name)
      eval(parse(text = x$RegisterCommand))
      message("###################################################")
    }
  )
  invisible(result)
}
