
# Setup -------------------------------------------------------------------



# Tests -------------------------------------------------------------------

context("Test exists_option()")

test_that( "TRUE if option exists",
           {
             expect_true(
               exists_option("config_name")
             )
           }
)

test_that( "FALSE if option does not exists",
           {
             expect_false(
               exists_option("some_nonsense")
             )
           }
)

test_that( "get_option returns correct value",
           {
             expect_equal(
               get_option("config_name"),
               "Master"
             )
           }
)

test_that( "get_option returns NULL if it does not exist",
           {
             expect_error(
               get_option("some_nonsense")
             )
           }
)

test_that( "set new option and expect NULL",
           {
             expect_null(
               set_option("some_nonsense", "test")
             )
             expect_equal(
               get_option("some_nonsense"),
               "test"
             )
           }
)

test_that( "set option and expect old value in return",
           {
             expect_equal(
               set_option("some_nonsense", "nothing"),
               "test"
             )
             expect_equal(
               get_option("some_nonsense"),
               "nothing"
             )
           }
)

# Teardown ----------------------------------------------------------------



