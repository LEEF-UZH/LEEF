#' Preprocessor flowcam data
#'
#' extract data from all \code{*_classes_*_data.csv} files
#' @return
#'
#' @importFrom dplyr bind_rows group_by summarise
#' @importFrom magrittr %>% %<>%
#' @importFrom readr read_csv cols col_double col_integer col_character col_date col_time col_datetime
#'
#' @examples
#' @export
extractor_flowcam <- function() {
  cat("\n########################################################\n")
  cat("\nExtracting flowcam...\n")

# Based on flowcam_classification_to_final_data.R ----------------------------------------
  # David Inauen, 19.06.2017

# Get csv file names ------------------------------------------------------

  flowcam_path <- file.path( DATA_options("to_be_imported"), "flowcam" )
  flowcam_files <- list.files(
    path = flowcam_path,
    pattern = ".*_classes_.*_data.csv",
    full.names = TRUE,
    recursive = TRUE
  )

  if (length(flowcam_files) == 0) {
    cat("nothing to extract\n")
    cat("\n########################################################\n")
    return(invisible(FALSE))
  }

# read in all data frames as list, way faster than read.csv ---------------------------------

  classes <- lapply(
    flowcam_files,
    readr::read_csv,
    col_types =
      cols(
        .default = col_double(),
        `Particle ID` = col_integer(),
        Class = col_character(),
        `Calibration Image` = col_integer(),
        Camera = col_integer(),
        `Capture X` = col_integer(),
        `Capture Y` = col_integer(),
        Date = col_date(format = ""),
        `Image File` = col_character(),
        `Image Height` = col_integer(),
        `Image Width` = col_integer(),
        `Image X` = col_integer(),
        `Image Y` = col_integer(),
        `Particles Per Chain` = col_integer(),
        `Source Image` = col_integer(),
        Time = col_time(format = ""),
        Timestamp = col_datetime(format = "")
      )
  ) %>%
    # combine intu one large tibble
    dplyr::bind_rows(.) %>%
    # add jar ID's to df
    dplyr::mutate(
      ID = strsplit(`Image File`, "_") %>%
        sapply("[", 4) %>%
        as.numeric %>%
        sprintf("B%02d", .)
    ) %>%
    # Define Groupings
    # dplyr::group_by(Class, ID, Date, treat, incubator) %>%
    dplyr::group_by(
      Class,
      ID,
      Date
    )

  # #### REMOVE / ADD COLOUMNS AND COMPRESS DF
  #
  # classes <- subset(df_temp, select = -c(Ch1 Area, Ch1 Peak, Ch1 Width, Ch2 Area, Ch2 Peak, Ch2 Width, Scatter Area, Scatter Peak, Scatter Width, Timestamp))


  # further changes, adding proper date, treat and incubator
  # classes$Date <- format(
  #   as.Date(
  #     classes$Date,
  #     "%d-%b-%Y"
  #   ),
  #   "%Y-%m-%d"
  # )

  # labeling treatment
  # target <- c("B01", "B02", "B03", "B04", "B05", "B06", "B07", "B08", "B09")
  # classes$treat <- ifelse(ID %in% target, "const", "fluc")
  # classes$treat <- as.factor(classes$treat)
  #
  # # labeling incubators
  # inc_182 <- c("B01", "B02", "B03")
  # inc_181 <- c("B04", "B05", "B06")
  # inc_180 <- c("B07", "B08", "B09")
  # inc_179 <- c("B10", "B11", "B12")
  # inc_178 <- c("B13", "B14", "B15")
  # inc_177 <- c("B16", "B17", "B18")
  # classes$incubator <- ifelse(ID %in% inc_182, "182", ifelse(ID %in% inc_181, "181", ifelse(ID %in% inc_180, "180", ifelse(ID %in% inc_179, "179", ifelse(ID %in% inc_178, "178", "177")))))
  # classes$incubator <- as.factor(classes$incubator)
  #
  # # dropping out further unenecessary coloumns
  # classes <- subset(classes, select = -c(Date, Time, Camera, Calibration Image, Filter Score, Date, Particles Per Chain))

  # summarise classes
  classes_aggregated <- classes %>%
    dplyr::  summarise(
      count = length(`Particle ID`),
      mean.area.abd = mean(`Area (ABD)`), sd.area.abd = sd(`Area (ABD)`),
      mean.area.filled = mean(`Area (Filled)`), sd.area.filled = sd(`Area (Filled)`),
      mean.aspect.ratio = mean(`Aspect Ratio`), sd.aspect.ratio = sd(`Aspect Ratio`),
      mean.blue = mean(`Average Blue`), sd.blue = sd(`Average Blue`),
      mean.green = mean(`Average Green`), sd.green = sd(`Average Green`),
      mean.red = mean(`Average Red`), sd.red = sd(`Average Red`),
      mean.circle.fit = mean(`Circle Fit`), sd.circle.fit = sd(`Circle Fit`),
      mean.circularity = mean(`Circularity`), sd.circularity = sd(`Circularity`),
      mean.circularity.hu = mean(`Circularity (Hu)`), sd.circularity.hu = sd(`Circularity (Hu)`),
      mean.compactness = mean(Compactness), sd.compactness = sd(Compactness),
      mean.convex.perimeter = mean(`Convex Perimeter`), sd.convex.perimeter = sd(`Convex Perimeter`),
      mean.convexity = mean(Convexity), sd.convexity = sd(Convexity),
      mean.diameter.asd = mean(`Diameter (ABD)`), sd.diameter.asd = sd(`Diameter (ABD)`),
      mean.diameter.esd = mean(`Diameter (ESD)`), sd.diameter.esd = sd(`Diameter (ESD)`),
      mean.edge.gradient = mean(`Edge Gradient`), sd.edge.gradietn = sd(`Edge Gradient`),
      mean.elongation = mean(Elongation), sd.elongation = sd(Elongation),
      mean.feret.angle.max = mean(`Feret Angle Max`), sd.feret.angle.max = sd(`Feret Angle Max`),
      mean.feret.angle.min = mean(`Feret Angle Min`), sd.feret.angle.min = sd(`Feret Angle Min`),
      mean.fiber.curl = mean(`Fiber Curl`), sd.fiber.curl = sd(`Fiber Curl`),
      mean.fiber.straightness = mean(`Fiber Straightness`), sd.fiber.straightness = sd(`Fiber Straightness`),
      mean.geodesic.aspect.ratio = mean(`Geodesic Aspect Ratio`), sd.geodensic.aspect.ratio = sd(`Geodesic Aspect Ratio`),
      mean.geodesic.length = mean(`Geodesic Length`), sd.geodesic.length = sd(`Geodesic Length`),
      mean.geodesic.thickness = mean(`Geodesic Thickness`), sd.geodesic.thickness = sd(`Geodesic Thickness`),
      mean.intensity = mean(Intensity), sd.intensity = sd(Intensity),
      mean.length = mean(Length), sd.length = sd(Length),
      mean.perimeter = mean(Perimeter), sd.perimeter = sd(Perimeter),
      mean.ratio.blue.green = mean(`Ratio Blue/Green`), sd.ratio.blue.green = sd(`Ratio Blue/Green`),
      mean.ratio.red.blue = mean(`Ratio Red/Blue`), sd.ratio.red.blue = sd(`Ratio Red/Blue`),
      mean.ratio.red.green = mean(`Ratio Red/Green`), sd.ratio.red.green = sd(`Ratio Red/Green`),
      mean.roughness = mean(Roughness), sd.roughness = mean(Roughness),
      mean.sigma.intensity = mean(`Sigma Intensity`), sd.sigma.intensity = sd(`Sigma Intensity`),
      mean.sum.intensity = mean(`Sum Intensity`), sd.sum.intensity = sd(`Sum Intensity`),
      mean.symmetry = mean(Symmetry), sd.symmetry = sd(Symmetry),
      mean.transparency = mean(Transparency), sd.transparency = sd(Transparency),
      mean.volume.abd = mean(`Volume (ABD)`), sd.volume.abd = sd(`Volume (ABD)`),
      mean.volume.esd = mean(`Volume (ESD)`), sd.volume.esd = sd(`Volume (ESD)`),
      mean.width = mean(Width), sd.width = sd(Width)
    )

# SAVE --------------------------------------------------------------------
  add_path <- file.path( DATA_options("last_added"), "flowcam" )
  dir.create( add_path )
  #
  saveRDS(
    object = classes,
    file = file.path(add_path, "flowcam_raw.rds")
  )
  #
  saveRDS(
    object = classes_aggregated,
    file = file.path(add_path, "flowcam_aggregated.rds")
  )

# Finalize ----------------------------------------------------------------

  cat("done\n")
  cat("\n########################################################\n")

  invisible(TRUE)
}
