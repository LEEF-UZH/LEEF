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
  on.exit(
    setwd(oldwd)
  )
  ##
  oldwd <- getwd()
  ##
  if (!(compression %in% c("none", "tar", "tar.gz"))) {
    stop("Conmpression", compression, "not supported!")
  }
  to_be_imported <-  get_option("to_be_imported")
  # new_data_extension <- get_option("config")$new_data_extension
  # new_files <- list.files( path = to_be_imported, pattern = new_data_extension )
  ##
  archivepath <- get_option("archive")

  if (
    !file.exists( file.path( to_be_imported, "file.sha256") ) |
    !file.exists( file.path( to_be_imported, "dir.sha256") )
  ) {
    stop("The new data has not been hashed - please run `hash_new_data() before running this command!")
  }
  ### TODO ### THIS TIME SHOULD BE TAKEN FROM THE RESULT FROM THE TTS WHEN TTS AVAILABLE
  if ( file.exists(file.path(to_be_imported, "TTS.result.yml")) ) {
    stop("TODO!")
    # timestamp <-
    # timestamp <- format( timestamp , "%Y-%m-%d--%H-%M-%S.TTS")
  } else {
    timestamp <- Sys.time()
    timestamp <- format( timestamp , "%Y-%m-%d--%H-%M-%S")
  }
  ##
  archivename <- ifelse(
    compression == "none",
    yes = paste(
      get_option("archive_name"),
      timestamp,
      sep = "."
    ),
    no = paste(
      get_option("archive_name"),
      timestamp,
      compression == "none",
      sep = "."
    )
  )

  archivefile <- file.path(archivepath, archivename)
  if ( file.exists( archivefile ) & !overwrite) {
    stop("The tar archive exists already - please set `overwrite = TRUE` if you want to overwrite them!")
  }
  ##
  switch(
    compression,
    tar = {
      oldwd <- setwd(get_option("to_be_imported"))
      utils::tar(
        tarfile = archivefile,
        files = "./",
        # compression = "gz",
        compression_level = 9
      )
      setwd(oldwd)
      f <- file( archivefile, open = "rb" )
      hash <- as.character( openssl::sha256( f ) )
      close(f)
      rm(f)
      hash <- paste(hash, archivename, sep = "  ")
      f <- file( file.path(archivepath, paste0(archivename, ".sha256") ) )
      writeLines(
        text = hash,
        con = f
      )
      close(f)
      rm(f)
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
      hash <- paste(hash, archivename, sep = "  ")
      f <- file( file.path(archivepath, paste0(archivename, ".sha256") ) )
      writeLines(
        text = hash,
        con = f
      )
      close(f)
      rm(f)
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
