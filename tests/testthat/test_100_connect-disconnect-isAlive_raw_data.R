context("Test connect_data()")

# Setup -------------------------------------------------------------------


testdir <- tempfile( pattern = "test_030_archive_new_data.")
dir.create( testdir )
file.copy(
  from = system.file("config.yml", package = "LEEF.Data"),
  to = testdir
)
setwd( testdir )
initialize_db( )


# Tests -------------------------------------------------------------------

test_that(
  "Error if nonsense backend",
  {
    x <- DATA_options("database")
    x$driver <- "dddd"
    DATA_options(database = x)
    expect_error(
      db_connect_data(),
      regex = NULL
    )
    expect_null(
      DATA_options("data_connection")
    )
  }
)


test_that(
  "disconnect_data() should return NULL",
  {
    expect_null(
      db_disconnect_data()
    )
    expect_null(
      DATA_options("data_connection")
    )
  }
)

test_that(
  "Returns true if 'RSQLite::SQLite()` backend",
  {
    x <- DATA_options("database")
    x$driver <- "RSQLite::SQLite()"
    DATA_options( database = x)
    expect_error(
      db_connect_data(),
      regex = NA
    )
    expect_true(
      db_connect_data()
    )
    expect_s4_class(
      DATA_options("data_connection"),
      "SQLiteConnection"
    )
  }
)

test_that(
  "db_isAlive_data returns TRUE if connection open",
  {
    expect_true(
      db_isAlive_data()
    )
  }
)

test_that(
  "disconnect_data() should return TRUE as connected",
  {
    expect_true(
      db_disconnect_data()
    )
    expect_null(
      DATA_options("data_connection")
    )
  }
)

test_that(
  "db_isAlive_data returns FALSE if connection closed",
  {
    x <- DATA_options("data_connection")
    expect_false(
      db_isAlive_data()
    )
  }
)

test_that(
  "db_isAlive_data returns FALSE if connection has nonsense value",
  {
    x <- DATA_options(data_connection = "test")$data_connection
    expect_false(
      db_isAlive_data()
    )
    expect_null(
      DATA_options("data_connection")
    )
  }
)

# Teardown ----------------------------------------------------------------

unlink( testdir, recursive = TRUE, force = TRUE )
