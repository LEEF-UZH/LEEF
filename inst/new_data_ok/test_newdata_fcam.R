context("New Data Test fcam.feather")
library(feather)

test_that(
  "Data can be loaded",
  {
    expect_error(
      nd <<- read_feather(
        file.path(
          getOption("new_data_dir"),
          "fcam.feather"
        )
      ),
      regexp = NA
    )
  }
)

test_that(
  "Names are OK",
  {
    expect_named( nd, nd_names )
  }
)

test_that(
  "Area..ABD. OK",
  {
    expect_gt( min(nd$Area..ABD.), 2)
    expect_lt( max(nd$Area..ABD.), 100)
  }
)
