#' Compress and checksum the \code{get_option("new_data_path)}
#'
#' Compress all files in \code{get_option("new_data_path")} into the directory \code{"NEW_DATA_PATH/../new_data_archive}
#' @return invisibly returns \code(TRUE)
#' @importFrom openssl sha512
#' @export
#'
#' @examples
tar_new_data <- function(){
  on.exit(
    setwd(oldwd)
  )
  oldwd <- getwd()
  ##
  new_data_dir <-  get_option("new_data_dir")
  # new_data_extension <- get_option("config")$new_data_extension
  # new_files <- list.files( path = new_data_dir, pattern = new_data_extension )
  ##
  tarpath <- get_option("new_data_archive")
  tarname <- paste(
    "new_data",
    format(Sys.time(), "%Y-%m-%d"),
    "tar.gz",
    sep = "."
  )
  tarfile <- file.path(tarpath, tarname)
  ##

  oldwd <- setwd(get_option("new_data_dir"))
  tar(
    tarfile = tarfile,
    files = "./",
    compression = "gz",
    compression_level = 9
  )
  setwd(oldwd)

  f <- file( tarfile, open = "rb" )
  hash <- as.character( openssl::sha512( f ) )
  close(f)
  rm(f)
  hash <- paste(hash, tarname, sep = "  ")
  f <- file( file.path(tarpath, paste0(tarname, ".sha512") ) )
  writeLines(
    text = hash,
    con = f
  )
  close(f)
  rm(f)

  invisible(TRUE)
}
