#' Extractor incubatortemp data
#'
#' Convert all \code{.cvs} files in \code{incubatortemp} folder to \code{data.frame} and save as \code{.rds} file.
#'
#' This function is extracting data to be added to the database (and therefore make accessible for further analysis and forecasting)
#' from \code{.csv} files.
#' @return
#'
#' @importFrom dplyr bind_rows
#' @importFrom magrittr %>% %<>%
#' @importFrom readr read_file locale read_tsv
#' @export
#'
#' @examples
extractor_incubatortemp <- function() {
  cat("\n########################################################\n")
  cat("\nExtracting Incubatortemp\n")

  # Get csv file names ------------------------------------------------------

  incubatortemp_path <- file.path( DATA_options("to_be_imported"), "incubatortemp" )
  incubatortemp_files <- list.files(
    path = incubatortemp_path,
    pattern = "*.txt",
    full.names = TRUE,
    recursive = TRUE
  )

  if (length(incubatortemp_files) == 0) {
    cat("nothing to extract\n")
    cat("\n########################################################\n")
    return(invisible(FALSE))
  }

# Read file ---------------------------------------------------------------

  itmp <- lapply(
    incubatortemp_files,
    function(fn) {
      fn %>%
        readr::read_file( locale = readr::locale(encoding = "UTF-16LE") ) %>%
        read_tsv %>%
        return
    }
  ) %>%
    # combine intu one large tibble
    dplyr::bind_rows(.)

# SAVE --------------------------------------------------------------------

  add_path <- file.path( DATA_options("last_added"), "incubatortemp" )
  dir.create( add_path )
  saveRDS(
    object = itmp,
    file = file.path(add_path, "incubatortemp.rds")
  )

# Finalize ----------------------------------------------------------------

  cat("done\n")
  cat("\n########################################################\n")

  invisible(TRUE)
}
