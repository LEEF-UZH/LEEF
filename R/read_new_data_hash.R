#' Read hash from new data file
#'
#' Function to read the hash of a new data file. The function looks for the file
#' \code{hash.sha512} in the \code{get_option("new_data_path")} directory.
#' @param file if given, function returns the hash of the file, if not, a
#'   dataframe containing the hashes
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
  file
) {
  result <- utils::read.table(
      file.path( get_option("new_data_dir"), "hash.sha512"),
      header = FALSE,
      stringsAsFactors = FALSE
  )
  result <- data.frame(
    file = result[,2],
    hash = result [,1],
    stringsAsFactors = FALSE
  )
  row.names(result) <- result$file

  if (!missing(file)) {
    result <- result[file,][["hash"]]
  }
  return(result)
}
