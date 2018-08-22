#' Compress and checksum the \code{get_option("new_data_path")}
#'
#' Compress all files in \code{get_option("new_data_path")} into the directory \code{"NEW_DATA_PATH/../archive"}
#'
#' @param compression which compression should be used for the archive. Thge following values are supported at the moment:
#' \describe{
#'    \item{\code{"none"}}{copy the to be imported data folder into archive}
#'    \item{\code{"tar"}}{tar the to be imported data folder}
#'    \item{\code{"tar.gz"}}{tar and gz compress the to be imported data folder}
#' }
#' Default is the value as defined in the config file.
#'
#' @param overwrite if \code{TRUE}, overwrite existing tar file; default is \code{FALSE}
#'
#' @return invisibly returns the name of the archivefile
#' @importFrom openssl sha256
#' @importFrom utils tar
#'
#' @export
#'
#' @examples
archive_new_data <- function(
  compression = get_option("config")$archive_compression,
  overwrite = FALSE
){
  ##
  oldwd <- getwd()
  on.exit(
    setwd(oldwd)
  )
  ##
  if (!(compression %in% c("none", "tar", "tar.gz"))) {
    stop("Conmpression", compression, "not supported!")
  }
  to_be_imported <-  get_option("to_be_imported")
  if (
    !file.exists( file.path( to_be_imported, "file.sha256") ) |
    !file.exists( file.path( to_be_imported, "dir.sha256") )
  ) {
    stop("The new data has not been hashed - please run `hash_new_data() before running this command!")
  }
  ##
  archivepath <- get_option("archive")
  timestamp <- Sys.time()
  timestamp <- format( timestamp , "%Y-%m-%d--%H-%M-%S")
  archivename <- paste(
    get_option("archive_name"),
    timestamp,
    compression,
    sep = "."
  )
  if (compression == "none") {
    gsub( ".none", "", archivename)
  }
  archivefile <- file.path(archivepath, archivename)
  if ( file.exists( archivefile ) & !overwrite) {
    stop("The archive exists already - please set `overwrite = TRUE` if you want to overwrite them!")
  }
  ##
  switch(
    compression,
    tar = {
      oldwd <- setwd(get_option("to_be_imported"))
      utils::tar(
        tarfile = archivefile,
        files = "./",
      )
      setwd(oldwd)
      f <- file( archivefile, open = "rb" )
      hash <- as.character( openssl::sha256( f ) )
      close(f)
      rm(f)
      hashln <- paste(hash, archivename, sep = "  ")
      f <- file( file.path(archivepath, paste0(archivename, ".sha256") ) )
      writeLines(
        text = hashln,
        con = f
      )
      close(f)
      rm(f)
      ##
      information <- get_option("config")$tts_info
      information$archivename <- archivefile
      #
      ROriginStamp::store_hash(
        hash = hash,
        error_on_fail = TRUE,
        information = information
      )
      ROriginStamp::get_hash_info(
        hash,
        file = paste0( archivefile, ".OriginStamp.hash-info.yml")
        )
    },
    tar.gz = {
      oldwd <- setwd(get_option("to_be_imported"))
      utils::tar(
        tarfile = archivefile,
        files = "./",
        compression = "gz",
        compression_level = 9
      )
      setwd(oldwd)
      f <- file( archivefile, open = "rb" )
      hash <- as.character( openssl::sha256( f ) )
      close(f)
      rm(f)
      hashln <- paste(hash, archivename, sep = "  ")
      f <- file( file.path(archivepath, paste0(archivename, ".sha256") ) )
      writeLines(
        text = hashln,
        con = f
      )
      close(f)
      rm(f)
      ##
      information <- get_option("config")$tts_info
      information$archivename <- archivefile
      #
      ROriginStamp::store_hash(
        hash = hash,
        error_on_fail = TRUE,
        information = information
      )
      ROriginStamp::get_hash_info(
        hash,
        file = paste0( archivename, ".OriginStamp.hash-info.yml")
      )
    },
    none = {
      dir.create( archivefile )
      file.copy(
        from = file.path( get_option("to_be_imported"), "." ),
        to = archivefile,
        recursive = TRUE,
        copy.date = TRUE
      )
    }
  )



  invisible(archivefile)
}
