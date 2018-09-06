context("New Data Test fcam.csv")

test_that(
  "Data can be loaded",
  {
    expect_error(
      DATA_options( tmp = read_new_data("fcam") ),
      regexp = NA
    )
  }
)

nd <- DATA_options("tmp")
DATA_options( tmp = NULL )

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

