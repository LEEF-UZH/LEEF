#' Create hash file of new_data
#'
#' This function is calculating
#' @param tts if \code{TRUE}, request Trusted Time Stamp from OriginStamp and results saved to \code{TTS.yml}; default \code{FALSE}
#' @param overwrite if \code{TRUE}, the file \code{hash.sha256} will be re-generated nd overwritten! default is \code{FALSE}
#'
#' @return invisibly \code{TRUE}
#'
#' @importFrom openssl sha256
#' @importFrom yaml write_yaml
#' @importFrom utils read.table
#'
#' @export
#'
#' @examples
hash_new_data <- function(
  tts = FALSE,
  overwrite = FALSE
){
  new_data_dir <- get_option("new_data_dir")
  new_data_extension <- get_option("config")$new_data_extension
  new_files <- list.files( path = new_data_dir, pattern = new_data_extension )

# Stop if files exist -----------------------------------------------------

  if (file.exists( file.path( new_data_dir, "hash.sha256") ) & !overwrite) {
    stop("The new data has been hashed already - please set `overwrite = TRUE` if you want to overwrite them!")
  }

# Hash files and save hashes ----------------------------------------------

  hash <- lapply(
    new_files,
    function(fn) {
      fnc <- file.path(new_data_dir, fn)
      f <- file( fnc, open = "rb" )
      hash <- as.character( openssl::sha256( f ) )
      close(f)
      rm(f)
      hash <- paste(hash, fn, sep = "  ")
    }
  )
  hash <- simplify2array(hash)
  f <- file( file.path(new_data_dir, "hash.sha256") )
  writeLines(
    text = hash,
    con = f
  )
  close(f)
  rm(f)

# Request tts  ------------------------------------------------------------

  if (tts) {
    stop("Not Implemented Yet!")
    hash <- utils::read.table(
      file.path(new_data_dir, "hash.sha256"),
      stringsAsFactors = FALSE
    )
    hash <- as.list( as.data.frame(t(hash), stringsAsFactors = FALSE) )
    ##
    result <- lapply(
      hash,
      function(hashi){
        info <- list(
          file = hashi[[2]],
          and_some_more = "more_to_come"
        )
        ROriginStamp::store_hash(
          hashi[[1]],
          error_on_fail = FALSE,
          ##### TODO error_on_Fail NEEDS TO BE CHANGED TO FALSE
          information = info
        )
      }
    )
    yaml::write_yaml(
      x = result,
      file = file.path(new_data_dir, "TTS.yml")
    )
  }
# finalize ----------------------------------------------------------------

  invisible(TRUE)
}
