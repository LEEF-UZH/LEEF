context("Test read_new_data()")

test_that( "Reads data correctly",
           {
             expect_equal_to_reference(
               read_new_data("fcam.csv"),
               file.path( get_option("pkg_path"), "test_data", "false", "fcam.rds" )
             )
           }
)
