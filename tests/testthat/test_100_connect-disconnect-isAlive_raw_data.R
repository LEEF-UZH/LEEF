context("Test connect_data()")

test_that(
  "Error if nonsense backend",
  {
    x <- get_option("config")
    x$data$backend$driver <- "dddd"
    set_option("config", x)
    expect_error(
      db_connect_data(),
      regex = NULL
    )
    expect_null(
      get_option("data_connection")
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
      get_option("data_connection")
    )
  }
)

test_that(
  "Returns true if 'RSQLite::SQLite()` backend",
  {
    x <- get_option("config")
    x$data$backend$driver <- "RSQLite::SQLite()"
    set_option("config", x)
    expect_error(
      db_connect_data(),
      regex = NA
    )
    expect_true(
      db_connect_data()
    )
    expect_s4_class(
      get_option("data_connection"),
      "SQLiteConnection"
    )
  }
)

test_that(
  "Returns true if 'RSQLite::SQLite()` backend",
  {
    db_disconnect_data()
    x <- get_option("config")
    x$data$backend$driver <- "RSQLite::SQLite()"
    x$data$backend$dbpath <- tempdir()
    x$data$backend$dbname <- "rest.sqlite"
    set_option("config", x)
    expect_error(
      db_connect_data(),
      regex = NA
    )
    expect_true(
      db_connect_data()
    )
    expect_s4_class(
      get_option("data_connection"),
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
      get_option("data_connection")
    )
  }
)

test_that(
  "db_isAlive_data returns FALSE if connection closed",
  {
    x <- get_option("data_connection")
    expect_false(
      db_isAlive_data()
    )
  }
)

test_that(
  "db_isAlive_data returns FALSE if connection has nonsense value",
  {
    x <- set_option("data_connection", "test")
    expect_false(
      db_isAlive_data()
    )
    expect_null(
      get_option("data_connection")
    )
  }
)
