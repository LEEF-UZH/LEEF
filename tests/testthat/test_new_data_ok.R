context("Test new_data_ok()")

test_that( "Returns data_test_results class",
           { expect_s3_class( ndo <<- new_data_ok(reporter = SilentReporter), "data_test_results") }
)

test_that( "Default Result is false",
           {
             expect_false( ndo$result )
           }
)

test_that( "Check Sample dataset",
           { expect_s3_class( ndo <<- new_data_ok( system.file("test_data", "false", package = packageName()), reporter = SilentReporter ), "data_test_results") }
)

test_that( "Default Result is false",
           {
             expect_false( ndo$result )
           }
)

test_that( "Default Result is true",
           {
             expect_true( new_data_ok( system.file("test_data", "true", package = packageName()), reporter = SilentReporter )$result )
           }
)

