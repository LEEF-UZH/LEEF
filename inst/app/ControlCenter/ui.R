#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
shinyUI(
    fluidPage(

        # Application title
        titlePanel("Control Centre for LEEF Pipeline"),

        # Sidebar with a slider input for number of bins
        sidebarLayout(
            # Sidebar panel for inputs ----
            sidebarPanel(

                tabsetPanel(
                    type = "tabs",
                    selected = 1,
                    tabPanel(
                        "Initialize",
                        fileInput("configfile", label = h3("Config File")),
                        hr(),
                        verbatimTextOutput("configfilename", placeholder = TRUE),
                        actionButton("initialize", label = "Initialize")
                    ),
                    tabPanel(
                        "Bemovi",
                        actionButton("check_bemovi", label = "Check"),
                        verbatimTextOutput("cb_result", placeholder = TRUE),
                    ),
                    tabPanel(
                        "Flowcam",
                        actionButton("check_flowcam", label = "Check")
                    ),
                    tabPanel(
                        "Flowcytometer",
                        actionButton("check_flowcytometer", label = "Check")
                    ),
                    tabPanel(
                        "Incubator temp",
                        actionButton("check_incubatortemp", label = "Check")
                    ),
                    tabPanel(
                        "Manualcount",
                        actionButton("check_manualcount", label = "Check")
                    ),
                    tabPanel(
                        "o2meter",
                        actionButton("check_o2meter", label = "Check")
                    ),
                    tabPanel(
                        "TOC",
                        actionButton("check_toc", label = "Check")
                    )
                )
            ),

            # Main panel for displaying outputs ----
            mainPanel(

                # Output: Data file ----
                tableOutput("contents")

            )
        )
    ))
