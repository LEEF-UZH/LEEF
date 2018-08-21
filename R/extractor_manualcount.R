#' Extractor manualcount data
#'
#' Convert all \code{.cvs} files in \code{manualcount} folder to \code{data.frame} and save as \code{.rds} file.
#'
#' This function is extracting data to be added to the database (and therefore make accessible for further analysis and forecasting)
#' from \code{.csv} files.
#' @return
#'
#' @importFrom dplyr bind_rows
#' @importFrom magrittr %>% %<>%
#' @importFrom readr read_csv
#' @export
#'
#' @examples
extractor_manualcount <- function() {
  cat("\n########################################################\n")
  cat("Extracting manualcount...\n")

  # Get csv file names ------------------------------------------------------

  manualcount_path <- file.path( get_option("to_be_imported"), "manualcount" )
  manualcount_files <- list.files(
    path = manualcount_path,
    pattern = "*.csv",
    full.names = TRUE,
    recursive = TRUE
  )

  if (length(manualcount_files) == 0) {
    cat("nothing to extract\n")
    cat("\n########################################################\n")
    return(invisible(FALSE))
  }

# Read file ---------------------------------------------------------------

  mc <- lapply(
    manualcount_files,
    readr::read_csv
  ) %>%
    # combine intu one large tibble
    dplyr::bind_rows(.)

# SAVE --------------------------------------------------------------------

  add_path <- file.path( get_option("last_added"), "manualcount" )
  dir.create( add_path )
  saveRDS(
    object = mc,
    file = file.path(add_path, "manualcount.rds")
  )

# Finalize ----------------------------------------------------------------

  cat("done\n")
  cat("\n########################################################\n")

  invisible(TRUE)
}
