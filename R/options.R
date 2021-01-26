#' Functions to read and write options
#'
#' Read or write the directories to be used in the processing. Directories do
#' not have to exist and will be created. Content will be overwritten without
#' confirmation! If no parameter is given, the directories will be returned a a list.
#' @param general.parameter \code{character} \code{vector} of length one containing the
#'   directory for the general parameter files
#' @param raw \code{character} \code{vector} of length one containing the
#'   directory for the raw data
#' @param pre_processed \code{character} \code{vector} of length one containing
#'   the directory for the pre_processed data
#' @param extracted \code{character} \code{vector} of length one containing the
#'   directory for the extracted data
#' @param archive \code{character} \code{vector} of length one containing the
#'   directory for the archived data
#' @param tools directory in which the tools are located
#' @return list of directories. If values have set, the value before the change.
#'
#' @rdname options
#'
#' @export
#'
#' @examples
#' opt_directories()
#'
#' opt_directories(raw = "./temp")
#'
opt_directories <- function(
  general.parameter,
  raw,
  pre_processed,
  extracted,
  archive,
  tools
){
  LEEF_options <- getOption("LEEF")
  if (is.null(LEEF_options)) {
    stop("Something is wrong - Options not initialized!")
  }
  ##
  old_dirs <- LEEF_options$directories
  dirs <- old_dirs
  read <- TRUE
  ##
  if (!missing(general.parameter)) {
    if (length(general.parameter) != 1) {
      stop("length of the vector has to be one!")
    }
   dirs$general.parameter <- general.parameter
   read <- FALSE
  }  
  if (!missing(raw)) {
    if (length(raw) != 1) {
      stop("length of the vector has to be one!")
    }
   dirs$raw <- raw
   read <- FALSE
  }
  if (!missing(pre_processed)) {
    if (length(pre_processed) != 1) {
      stop("length of the vector has to be one!")
    }
    dirs$pre_processed <- pre_processed
    read <- FALSE
  }
  if (!missing(extracted)) {
    if (length(extracted) != 1) {
      stop("length of the vector has to be one!")
    }
    dirs$extracted <- extracted
    read <- FALSE
  }
  if (!missing(archive)) {
    if (length(archive) != 1) {
      stop("length of the vector has to be one!")
    }
    dirs$archive <- archive
    read <- FALSE
  }
  if (!missing(tools)) {
    if (length(tools) != 1) {
      stop("length of the vector has to be one!")
    }
    dirs$tools <- tools
    read <- FALSE
  }
  ##
  if (!read) {
    LEEF_options$directories <- dirs
    options(LEEF = LEEF_options)
    invisible( old_dirs )
  } else {
    return( old_dirs )
  }

}




