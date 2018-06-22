#' Create hash file of new_data
#'
#' This function is calculating the \bold{file hash} for each subdirectory and
#' file and storing it in a \code{files.sha256} file and finally calculates the
#' \bold{directory hash} for this file and saves it in the file
#' \code{dir.sh256}. It is calculating one checksum file for the whole dataset
#' as well which is stored in the ToBeImported directory.
#' @param tts if \code{TRUE}, request Trusted Time Stamp for \bold{directory
#'   hash} from OriginStamp and results saved to \code{TTS.result.yml} and
#'   download the seed into the file \code{TTS.seed}; default \code{FALSE}
#' @param overwrite if \code{TRUE}, the files \code{file.sha256} and
#'   \code{dir.sha256} will be re-generated and overwritten! default is
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

  # Helper function ---------------------------------------------------------

  hash_in_dir <- function(
    dir,
    recursiveHash = FALSE,
    getTTS = tts
  ) {
    new_files <- list.files(
      path = dir,
      recursive = recursiveHash
    )
    if (length(new_files) == 0) {
      break()
    }
    new_files <- sort(new_files)

    filehash <- file.path( dir, "file.sha256" )
    dirhash  <- file.path( dir, "dir.sha256"  )

    # Stop if files exist -----------------------------------------------------

    if (
      file.exists( filehash ) &
      file.exists( dirhash )  &
      !overwrite
    ) {
      stop("The new data in directory\n", dir, "\nhas been hashed already - please set `overwrite = TRUE` if you want to overwrite them!")
    }

    # Hash create files.sha256 ----------------------------------------------

    hash <- lapply(
      new_files,
      function(fn) {
        fnc <- file.path( dir, fn )
        f <- file( fnc, open = "rb" )
        hash <- as.character( openssl::sha256( f ) )
        close(f)
        rm(f)
        hash <- paste(hash, fn, sep = "  ")
      }
    )
    hash <- simplify2array(hash)
    f <- file( filehash )
    writeLines(
      text = hash,
      con = f
    )
    close(f)
    rm(f)


    # Create dir.sha256 ---------------------------------------------------

    f <- file(  file.path( dir, "file.sha256"), open = "rb" )
    hash <- as.character( openssl::sha256( f ) )
    close(f)
    rm(f)
    hash <- paste(hash, "file.sha256", sep = "  ")
    f <- file( dirhash )
    writeLines(
      text = hash,
      con = f
    )
    close(f)
    rm(f)

    # Request tts  ------------------------------------------------------------

    if (getTTS) {
      stop("Not Implemented Yet!")
      hash <- utils::read.table(
        file.path(dir, "dir.sha256"),
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
        file = file.path(dir, "TTS.result.yml")
      )

      ROriginStamp::get_complete_seed_file(
        hash = hash,
        file = "TTS.seed"
      )
    }

  }

# Iterate through subdirectories ------------------------------------------

  dirs <- list.dirs( get_option("to_be_imported"), recursive = TRUE )
  print(dirs[[1]])
  hash_in_dir(
    dir = dirs[1],
    recursiveHash = TRUE,
    getTTS = tts
  )
  for ( d in dirs[-1] ) {
    print(d)
    hash_in_dir(
      dir = d,
      recursiveHash = FALSE,
      getTTS = tts
    )
  }

# finalize ----------------------------------------------------------------

  invisible(TRUE)

}
