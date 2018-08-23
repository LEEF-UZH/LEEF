#' Create folder structure for data import and processing
#'
#' @return invisible \code{TRUE}
#' @export
#'
#' @examples
initialize_DB <- function(){

# ToBeImported folder structure -------------------------------------------
  dir.create(            get_option("to_be_imported"),                    showWarnings = FALSE )
  dir.create( file.path( get_option("to_be_imported"), "bemovi" ),        showWarnings = FALSE )
  dir.create( file.path( get_option("to_be_imported"), "flowcam" ),       showWarnings = FALSE )
  dir.create( file.path( get_option("to_be_imported"), "flowcytometer" ), showWarnings = FALSE )
  dir.create( file.path( get_option("to_be_imported"), "incubatortemp" ), showWarnings = FALSE )
  dir.create( file.path( get_option("to_be_imported"), "manualcount" ),   showWarnings = FALSE )
  dir.create( file.path( get_option("to_be_imported"), "respirator" ),    showWarnings = FALSE )

# Archive folder structure ------------------------------------------------

  dir.create( get_option("archive"), showWarnings = FALSE )

# LastAdded folder structure ----------------------------------------------

  dir.create( get_option("last_added"), showWarnings = FALSE )



}
