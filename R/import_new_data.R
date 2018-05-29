import_new_data <- function(
  new_data_dir = file.path( get_option("pkg_dir"), "new_data" )
) {
  if (new_data_ok( new_data_dir = new_data_dir)) {
    for (fn in list.files( path = new_data_dir, pattern = "*.csv")) {
      write_raw_data(
        name = gsub(".csv", "", fn),
        value = read.csv(fn)
      )
    }
    result <- TRUE
  } else {
    warn("Here we need the report of the error!")
    result <- FALSE
  }
  return(result)
}
