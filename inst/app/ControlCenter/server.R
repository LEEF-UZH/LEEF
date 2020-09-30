#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(LEEF)

# Define server logic
shinyServer(function(input, output) {

  # Anything that calls autoInvalidate will automatically invalidate
  # every 2 seconds.
  autoInvalidate <- reactiveTimer(2000)


  output$configfilename <- renderText(
    if( is.null(input$configfile$name) ) {
      "Default as in LEEF package"
    } else {
      input$configfile$name
    }
  )
  # output$cb_result <- renderText(
  #     output$cb_result
  # )
  ##



# Actions -----------------------------------------------------------------

  observeEvent(
    input$initialize,
    {
      if ( is.null(input$configfile$datapath) ) {
        initialize()
      } else {
        initialize(config_file = input$configfile$datapath)
      }
    }
  )

  # actions bemovi  ----------------------------------------------------------------

  observeEvent(
    input$new_data_bemovi,
    ignoreNULL = TRUE,
    handlerExpr = withProgress(
      message = 'Checking and importing files - this might take some time',
      min = 0,
      max = 1,
      value = 0,
      {
        output$new_data_bemovi_result <- renderPrint("Processing...")
        x <- LEEF.measurement.bemovi::add_new_data(
          input = file.path( "~", "LEEF", "000.NewData", "bemovi"),
          output = file.path("~", "LEEF", opt_directories()$raw)
        )
        output$new_data_bemovi_result <- renderPrint( cat("Done.", "Please Check input directory for possible error messages!", sep = "\n") )
        output$files_bemovi_input <- renderPrint( cat(list.files(file.path("~", "LEEF", "000.NewData", "bemovi")), sep = "\n") )
        output$files_bemovi_output <- renderPrint( cat(list.files(file.path("~", "LEEF", "0.raw.data", "bemovi")), sep = "\n") )
      }
    )
  )

  observeEvent(
    input$extract_points_bemovi,
    ignoreNULL = TRUE,
    handlerExpr = withProgress(
      message = 'Extracting Points - this might take some time',
      min = 0,
      max = 1,
      value = 0,
      {
        output$nextract_points_bemovi_result <- renderPrint("Processing...")
        if ( !isTRUE(LEEF.measurement.bemovi::raw_data_ok( file.path("~", "LEEF", "0.raw.data"))) ) {
          output$nextract_points_bemovi_result <- renderPrint("Raw Data can not be processed yet!")
        } else {
          LEEF.measurement.bemovi::pre_processor_bemovi(
            input = file.path("~", "LEEF", "0.raw.data"),
            output = file.path("~", "LEEF", "1.pre-processed.data")
          )
          LEEF.measurement.bemovi::extractor_bemovi_particle(
            input = file.path("~", "LEEF", "1.pre-processed.data"),
            output = file.path("~", "LEEF", "2.extracted.data")
          )
        }
        # x <- LEEF.measurement.bemovi::add_new_data(
        #   input = file.path( "~", "LEEF", "000.NewData", "bemovi"),
        #   output = file.path("~", "LEEF", opt_directories()$raw)
        # )
        # output$new_data_bemovi_result <- renderPrint( cat("Done.", "Please Check input directory for possible error messages!", sep = "\n") )
        # output$files_bemovi_input <- renderPrint( cat(list.files(file.path("~", "LEEF", "000.NewData", "bemovi")), sep = "\n") )
        # output$files_bemovi_output <- renderPrint( cat(list.files(file.path("~", "LEEF", "0.raw.data", "bemovi")), sep = "\n") )
      }
    )
  )

  # actions flowcam  ---------------------------------------------------------------------

  observeEvent(
    input$new_data_flowcam,
    ignoreNULL = TRUE,
    handlerExpr = withProgress(
      message = 'Checking and importing files - this might take some time',
      min = 0,
      max = 1,
      value = 0,
      {
        output$new_data_flowcam_result <- renderPrint("Processing...")
        x <- LEEF.measurement.flowcam::add_new_data(
          input = file.path( "~", "LEEF", "000.NewData", "flowcam"),
          output = file.path("~", "LEEF", opt_directories()$raw)
        )
        output$new_data_flowcam_result <- renderPrint( cat("Done.", "Please Check input directory for possible error messages!", sep = "\n") )
        output$files_flowcami_input <- renderPrint( cat(list.files(file.path("~", "LEEF", "000.NewData", "flowcam")), sep = "\n") )
        output$files_flowcam_output <- renderPrint( cat(list.files(file.path("~", "LEEF", "0.raw.data", "flowcam")), sep = "\n") )
      }
    )
  )

  # actions flowcytometer---------------------------------------------------------------------

  observeEvent(
    input$new_data_flowcytometer,
    ignoreNULL = TRUE,
    handlerExpr = withProgress(
      message = 'Checking and importing files - this might take some time',
      min = 0,
      max = 1,
      value = 0,
      {
        output$new_data_flowcytometer_result <- renderPrint("Processing...")
        x <- LEEF.measurement.flowcytometer::add_new_data(
          input = file.path( "~", "LEEF", "000.NewData", "flowcytometer"),
          output = file.path("~", "LEEF", opt_directories()$raw)
        )
        output$new_data_flowcytometer_result <- renderPrint( cat("Done.", "Please Check input directory for possible error messages!", sep = "\n") )
        output$files_flowcytometeri_input <- renderPrint( cat(list.files(file.path("~", "LEEF", "000.NewData", "flowcytometer")), sep = "\n") )
        output$files_flowcytometer_output <- renderPrint( cat(list.files(file.path("~", "LEEF", "0.raw.data", "flowcytometer")), sep = "\n") )
      }
    )
  )

  # actions incubatortemp  ---------------------------------------------------------------------

  observeEvent(
    input$new_data_incubatortemp,
    ignoreNULL = TRUE,
    handlerExpr = withProgress(
      message = 'Checking and importing files - this might take some time',
      min = 0,
      max = 1,
      value = 0,
      {
        output$new_data_incubatortemp_result <- renderPrint("Processing...")
        x <- LEEF.measurement.incubatortemp::add_new_data(
          input = file.path( "~", "LEEF", "000.NewData", "incubatortemp"),
          output = file.path("~", "LEEF", opt_directories()$raw)
        )
        output$new_data_incubatortemp_result <- renderPrint( cat("Done.", "Please Check input directory for possible error messages!", sep = "\n") )
        output$files_incubatortempi_input <- renderPrint( cat(list.files(file.path("~", "LEEF", "000.NewData", "incubatortemp")), sep = "\n") )
        output$files_incubatortemp_output <- renderPrint( cat(list.files(file.path("~", "LEEF", "0.raw.data", "incubatortemp")), sep = "\n") )
      }
    )
  )

  # actions manualcount  ---------------------------------------------------------------------

  observeEvent(
    input$new_data_manualcount,
    ignoreNULL = TRUE,
    handlerExpr = withProgress(
      message = 'Checking and importing files - this might take some time',
      min = 0,
      max = 1,
      value = 0,
      {
        output$new_data_manualcount_result <- renderPrint("Processing...")
        x <- LEEF.measurement.manualcount::add_new_data(
          input = file.path( "~", "LEEF", "000.NewData", "manualcount"),
          output = file.path("~", "LEEF", opt_directories()$raw)
        )
        output$new_data_manualcount_result <- renderPrint( cat("Done.", "Please Check input directory for possible error messages!", sep = "\n") )
        output$files_manualcounti_input <- renderPrint( cat(list.files(file.path("~", "LEEF", "000.NewData", "manualcount")), sep = "\n") )
        output$files_manualcount_output <- renderPrint( cat(list.files(file.path("~", "LEEF", "0.raw.data", "manualcount")), sep = "\n") )
      }
    )
  )

  # actions o2meter  ---------------------------------------------------------------------

  observeEvent(
    input$new_data_o2meter,
    ignoreNULL = TRUE,
    handlerExpr = withProgress(
      message = 'Checking and importing files - this might take some time',
      min = 0,
      max = 1,
      value = 0,
      {
        output$new_data_o2meter_result <- renderPrint("Processing...")
        x <- LEEF.measurement.o2meter::add_new_data(
          input = file.path( "~", "LEEF", "000.NewData", "o2meter"),
          output = file.path("~", "LEEF", opt_directories()$raw)
        )
        output$new_data_o2meter_result <- renderPrint( cat("Done.", "Please Check input directory for possible error messages!", sep = "\n") )
        output$files_o2meteri_input <- renderPrint( cat(list.files(file.path("~", "LEEF", "000.NewData", "o2meter")), sep = "\n") )
        output$files_o2meter_output <- renderPrint( cat(list.files(file.path("~", "LEEF", "0.raw.data", "o2meter")), sep = "\n") )
      }
    )
  )

  # actions toc  ---------------------------------------------------------------------

  observeEvent(
    input$new_data_toc,
    ignoreNULL = TRUE,
    handlerExpr = withProgress(
      message = 'Checking and importing files - this might take some time',
      min = 0,
      max = 1,
      value = 0,
      {
        output$new_data_toc_result <- renderPrint("Processing...")
        x <- LEEF.measurement.toc::add_new_data(
          input = file.path( "~", "LEEF", "000.NewData", "toc"),
          output = file.path("~", "LEEF", opt_directories()$raw)
        )
        output$new_data_toc_result <- renderPrint( cat("Done.", "Please Check input directory for possible error messages!", sep = "\n") )
        output$files_toci_input <- renderPrint( cat(list.files(file.path("~", "LEEF", "000.NewData", "toc")), sep = "\n") )
        output$files_toc_output <- renderPrint( cat(list.files(file.path("~", "LEEF", "0.raw.data", "toc")), sep = "\n") )
      }
    )
  )

  # Auto update -------------------------------------------------------------

  observe({
    # Invalidate and re-execute this reactive expression every time the
    # timer fires.
    autoInvalidate()

    # Do something each time this is invalidated.

    ## autoupdate bemovi  ------------------------------------------------------------------

    output$files_bemovi_input <- renderPrint( cat(list.files(file.path("~", "LEEF", "000.NewData", "bemovi")), sep = "\n") )
    output$files_bemovi_output <- renderPrint( cat(list.files(file.path("~", "LEEF", "0.raw.data", "bemovi")), sep = "\n") )
    output$ok_bemovi_output <- renderPrint( LEEF.measurement.bemovi::raw_data_ok( file.path("~", "LEEF", "0.raw.data") ) )

    ## autoupdate Flowcam  ------------------------------------------------------------------
    output$files_flowcam_input <- renderPrint( cat(list.files(file.path("~", "LEEF", "000.NewData", "flowcam")), sep = "\n") )
    output$files_flowcam_output <- renderPrint( cat(list.files(file.path("~", "LEEF", "0.raw.data", "flowcam")), sep = "\n") )
    output$ok_flowcam_output <- renderPrint( LEEF.measurement.flowcam::raw_data_ok( file.path("~", "LEEF", "0.raw.data") ) )

    ## autoupdate flowcytometer  ------------------------------------------------------------------
    output$files_flowcytometer_input <- renderPrint( cat(list.files(file.path("~", "LEEF", "000.NewData", "flowcytometer")), sep = "\n") )
    output$files_flowcytometer_output <- renderPrint( cat(list.files(file.path("~", "LEEF", "0.raw.data", "flowcytometer")), sep = "\n") )
    output$ok_flowcytometer_output <- renderPrint( LEEF.measurement.flowcytometer::raw_data_ok( file.path("~", "LEEF", "0.raw.data") ) )

    ## autoupdate incubatortemp  ------------------------------------------------------------------
    output$files_incubatortemp_input <- renderPrint( cat(list.files(file.path("~", "LEEF", "000.NewData", "incubatortemp")), sep = "\n") )
    output$files_incubatortemp_output <- renderPrint( cat(list.files(file.path("~", "LEEF", "0.raw.data", "incubatortemp")), sep = "\n") )
    output$ok_incubatortemp_output <- renderPrint( LEEF.measurement.incubatortemp::raw_data_ok( file.path("~", "LEEF", "0.raw.data") ) )

    ## autoupdate manualcount  ------------------------------------------------------------------
    output$files_manualcount_input <- renderPrint( cat(list.files(file.path("~", "LEEF", "000.NewData", "manualcount")), sep = "\n") )
    output$files_manualcount_output <- renderPrint( cat(list.files(file.path("~", "LEEF", "0.raw.data", "manualcount")), sep = "\n") )
    output$ok_manualcount_output <- renderPrint( LEEF.measurement.manualcount::raw_data_ok( file.path("~", "LEEF", "0.raw.data") ) )

    ## autoupdate o2meter  ------------------------------------------------------------------
    output$files_o2meter_input <- renderPrint( cat(list.files(file.path("~", "LEEF", "000.NewData", "o2meter")), sep = "\n") )
    output$files_o2meter_output <- renderPrint( cat(list.files(file.path("~", "LEEF", "0.raw.data", "o2meter")), sep = "\n") )
    output$ok_o2meter_output <- renderPrint( LEEF.measurement.o2meter::raw_data_ok( file.path("~", "LEEF", "0.raw.data") ) )

    ## autoupdate toc  ------------------------------------------------------------------
    output$files_toc_input <- renderPrint( cat(list.files(file.path("~", "LEEF", "000.NewData", "toc")), sep = "\n") )
    output$files_toc_output <- renderPrint( cat(list.files(file.path("~", "LEEF", "0.raw.data", "toc")), sep = "\n") )
    output$ok_toc_output <- renderPrint( LEEF.measurement.toc::raw_data_ok( file.path("~", "LEEF", "0.raw.data") ) )

  })
}
)
