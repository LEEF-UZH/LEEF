#' Split bemovi filder into a number of bemovi. folders with a maximum of
#' per_batch video files
#'
#' @param per_batch maximum number of movies per batch
#' @param bemovi_dir bas directory in which the \code{bemovi} directory is
#'   located
#' @param overwrite if \code{TRUE}, all folders starting with \code{bemovi.} in
#'   the \code{bemovi_dir} will be deleted
#'
#' @importFrom utils read.table write.table
#'
#' @return the maximum id used
#' @export
#'
#' @examples
#' \dontrun{
#' split_bemovi(per_batch = 5)
#' }
split_bemovi <- function(
  per_batch = 30,
  bemovi_dir = file.path(".", "0.raw.data"),
  overwrite = TRUE
){
  vd <- read.table(
    file.path(bemovi_dir, "bemovi", "video.description.txt"),
    header = TRUE
  )
  if (overwrite) {
    dirs <- grep(
      pattern = "^bemovi\\..*",
      x = list.dirs(
        path = bemovi_dir,
        recursive = FALSE,
        full.names = FALSE
      ),
      value = TRUE
    )
    unlink(
      x = file.path(bemovi_dir, dirs),
      recursive = TRUE,
      force = TRUE,
      expand = TRUE
    )
  }
  for (id in 1:ceiling(nrow(vd) / per_batch)) {
    maxid <- min(per_batch, nrow(vd))
    vd_id <- vd[1:maxid,]
    vd <- vd[-(1:maxid),]

    fns <- vd_id$file

    fns <- list.files(
      file.path( bemovi_dir, "bemovi"),
      pattern = paste0(fns, collapse = "|"),
      recursive = FALSE,
      full.names = FALSE
    )

    bemovi_dir_id <- paste0("bemovi.", id )
    dir.create( file.path(bemovi_dir, bemovi_dir_id) )
    file.copy(
      from = file.path(bemovi_dir, "bemovi", fns),
      to = file.path(bemovi_dir, bemovi_dir_id)
    )
    add_files <- grep(
      list.files( file.path(bemovi_dir, "bemovi") ),
      pattern = "\\.cxd",
      invert = TRUE,
      value = TRUE
    )
    file.copy(
      from = file.path(bemovi_dir, "bemovi", add_files),
      to = file.path(bemovi_dir, bemovi_dir_id)
    )
    write.table(
      x = vd_id,
      file = file.path(bemovi_dir, bemovi_dir_id, "video.description.txt"),
      row.names = FALSE,
      quote = F,
      sep = '\t',
      append = FALSE
    )
  }
  return(id)
}
