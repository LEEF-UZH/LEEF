#' Add or replace additor
#'
#' Adding a named function to the queue of db_additors. If the named function already exists will it be replaced.
#'
#' The functions must not require any arguments.
#' @param fun function which is run during addittion of the data to the database.
#'
#' @return invisiby the db_additor queue. A \code{list} which is processed
#' @export
#'
#' @examples
add_extractor <- function(fun) {
  if (!is.function(fun)) {
    stop( "fun needs to be a function!")
  }
  pp <- DATA_options("db_additors")
  funname <- deparse(substitute(fun))
  pp[[funname]] <- fun
  DATA_options( db_additors = pp )
  invisible( DATA_options("additors") )
}
