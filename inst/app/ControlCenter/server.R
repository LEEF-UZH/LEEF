#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
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
  observeEvent(
    input$initialize,
    {
      setwd("~/LEEF")
      if ( is.null(input$configfile$datapath) ) {
        initialize()
      } else {
        initialize(config_file = input$configfile$datapath)
      }
    }
  )
  ##
  observeEvent(
    input$check_bemovi,
    {
      output$cb_result <- renderUI(LEEF.measurement.bemovi::raw_data_ok("0.raw.data.bemovi"))
    }
  )
})
