#' Create hash file of new_data
#'
#'
#' @param tts if \code(TRUE), request Trusted Time Stamp from OriginStamp and results saved to \code{TTS.yml}; default \code{FALSE}
#'
#' @return invisibly \code(TRUE)
#' @export
#'
#' @examples
hash_new_data <- function(
  tts = FALSE
){
  new_data_dir <- get_option("new_data_dir")
  new_data_extension <- get_option("config")$new_data_extension
  new_files <- list.files( path = new_data_dir, pattern = new_data_extension )

# Hash files and save hashes ----------------------------------------------

  hash <- lapply(
    new_files,
    function(fn) {
      fnc <- file.path(new_data_dir, fn)
      f <- file( fnc, open = "rb" )
      hash <- as.character( openssl::sha512( f ) )
      close(f)
      rm(f)
      hash <- paste(hash, fn, sep = "  ")
    }
  )
  hash <- simplify2array(hash)
  f <- file( file.path(new_data_dir, "hash.sha512") )
  writeLines(
    text = hash,
    con = f
  )
  close(f)
  rm(f)

# Request tts  ------------------------------------------------------------

  if (tts) {
    stop("Not Implemented Yet!")
    hash <- read.table(
      file.path(new_data_dir, "hash.sha512"),
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
