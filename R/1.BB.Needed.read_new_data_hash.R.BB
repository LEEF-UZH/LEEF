#' Read hash from new data file
#'
#' Function to read the hash of a new data file. The function looks for the file
#' \code{hash.sha256} in the \code{DATA_options("to_be_imported")} directory.
#' @param file if given, function returns the hash of the file, if not, a
#'   dataframe containing the hashes
#' @param hash_file name of the hash file which should be read
#' @param hash_dir directory of hash file
#'
#' @return the hash of the file (if given), otherwise a \code{data.frame}
#'   containing the columns \code{file} containing the file names and
#'   \code{hash} containing the hashes. The row names are the file names as
#'   well.
#'
#' @importFrom utils read.table
#'
#' @export
#'
#' @examples
read_new_data_hash <- function(
  file,
  hash_file = "file.sha256",
  hash_dir = DATA_options("to_be_imported")
) {
  result <- utils::read.table(
      file.path( hash_dir, hash_file),
      header = FALSE,
      stringsAsFactors = FALSE
  )
  result <- data.frame(
    file = result[,2],
    hash = result[,1],
    stringsAsFactors = FALSE
  )
  row.names(result) <- result$file

  if (!missing(file)) {
    result <- result[file,][["hash"]]
  }
  return(result)
}
