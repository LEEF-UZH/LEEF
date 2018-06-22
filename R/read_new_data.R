#' Read new data file
#'
#' Function to read a new data file. The function looks for the file in the \code{get_option("new_data_path")} directory.
#' It sets values to define the format used to guarantee consistency.
#' @param name of the file in \code{get_option("new_data_path")} to be read \bold{without} externsion
#'
#' @return data frame containing the new data
#'
#' @importFrom utils read.csv
#' @export
#'
#' @examples
read_new_data <- function(
  file
) {
  if (get_option("config")$new_data_extension == ".csv") {
    utils::read.csv(
      file.path( get_option("to_be_imported"), paste0(file, get_option("config")$new_data_extension) ),
      header = TRUE,
      sep = ",",
      quote = "\"",
      dec = ".",
      fill = TRUE,
      comment.char = ""
    )
  } else {
    stop("The new_data_extension ", get_option("config")$new_data_extension, " is not yet supported." )
  }
}
