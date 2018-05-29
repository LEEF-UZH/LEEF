context("New Data Test fcam.csv")

test_that(
  "Data can be loaded",
  {
    expect_error(
      set_option(
        "fcam",
        read.csv(
          file.path(
            getOption("new_data_dir"),
            "fcam.csv"
          )
        )
      ),
      regexp = NA
    )
  }
)

nd <- get_option("fcam")

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
