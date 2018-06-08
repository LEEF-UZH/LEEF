#' Create hash file of new_data
#'
#' This function is calculating the \bold{file hash} for each file and storing
#' it in a \code{files.sha256.txt} file and finally calculates the
#' \bold{directory hash} for this file and saves it in the file
#' \code{dir.sh256.txt}
#' @param tts if \code{TRUE}, request Trusted Time Stamp for \bold{directory
#'   hash} from OriginStamp and results saved to \code{TTS.yml} and download the
#'   seed into the file \code{seed.HASH.txt}; default \code{FALSE}
#' @param overwrite if \code{TRUE}, the files \code{file.sha256.txt} and
#'   \code{dir.sha256.txt} will be re-generated and overwritten! default is
#'   \code{FALSE}. Only one ore none of these files exist, both will be
#'   re-generated.
#'
#' @return invisibly \code{TRUE}
#'
#' @importFrom openssl sha256
#' @importFrom yaml write_yaml
#' @importFrom utils read.table
#' @importFrom ROriginStamp store_hash get_complete_seed_file
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
  new_files <- sort(new_files)
# Stop if files exist -----------------------------------------------------

  if (
    file.exists( file.path( new_data_dir, "file.sha256.txt") ) &
    file.exists( file.path( new_data_dir, "dir.sha256.txt") )  &
    !overwrite
  ) {
    stop("The new data has been hashed already - please set `overwrite = TRUE` if you want to overwrite them!")
  }

# Hash create files.sha256.txt ----------------------------------------------

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
  f <- file( file.path(new_data_dir, "file.sha256.txt") )
  writeLines(
    text = hash,
    con = f
  )
  close(f)
  rm(f)


# Create dir.sha256.txt ---------------------------------------------------

  f <- file(  file.path(new_data_dir, "file.sha256.txt"), open = "rb" )
  hash <- as.character( openssl::sha256( f ) )
  close(f)
  rm(f)
  hash <- paste(hash, "file.sha256.txt", sep = "  ")
  f <- file( file.path(new_data_dir, "dir.sha256.txt") )
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

    ROriginStamp::get_complete_seed_file(
      hash = hash,
      file = paste("seed.", hash, ".txt")
    )
  }

# finalize ----------------------------------------------------------------

  invisible(TRUE)
}
