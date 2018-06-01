context("Test connect_raw_data()")

test_that(
  "Error if nonsense backend",
  {
    x <- get_option("config")
    x$data$backend$driver <- "dddd"
    set_option("config", x)
    expect_error(
      connect_raw_data(),
      regex = NULL
    )
    expect_null(
      get_option("raw_data_connection")
    )
  }
)

test_that(
  "disconnect_raw_data() should return NULL",
  {
    expect_null(
      disconnect_raw_data()
    )
    expect_null(
      get_option("raw_data_connection")
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
      connect_raw_data(),
      regex = NA
    )
    expect_true(
      connect_raw_data()
    )
    expect_s4_class(
      get_option("raw_data_connection"),
      "SQLiteConnection"
    )
  }
)

test_that(
  "disconnect_raw_data() should return TRUE as connected",
  {
    expect_true(
      disconnect_raw_data()
    )
    expect_null(
      get_option("raw_data_connection")
    )
  }
)
