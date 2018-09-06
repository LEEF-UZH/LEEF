#' Extractor respirometer data
#'
#' Convert all \code{.cvs} files in \code{respirometer} folder to \code{data.frame} and save as \code{.rds} file.
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
extractor_respirometer <- function() {
  cat("\n########################################################\n")
  cat("Extracting respirometer\n")

  # Get csv file names ------------------------------------------------------

  respirometer_path <- file.path( DATA_options("to_be_imported"), "respirometer" )
  respirometer_files <- list.files(
    path = respirometer_path,
    pattern = "*.csv",
    full.names = TRUE,
    recursive = TRUE
  )

  if (length(respirometer_files) == 0) {
    cat("nothing to extract\n")
    cat("\n########################################################\n")
    return(invisible(FALSE))
  }

# Read file ---------------------------------------------------------------

  res <- lapply(
    respirometer_files,
    readr::read_csv2,
    skip = 1
  ) %>%
    # combine intu one large tibble
    dplyr::bind_rows(.) %>%
    dplyr::filter(Date != "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!")

# SAVE --------------------------------------------------------------------

  add_path <- file.path( DATA_options("last_added"), "respirometer" )
  dir.create( add_path )
  saveRDS(
    object = res,
    file = file.path(add_path, "respirometer.rds")
  )

# Finalize ----------------------------------------------------------------

  cat("done\n")
  cat("\n########################################################\n")

  invisible(TRUE)
}
