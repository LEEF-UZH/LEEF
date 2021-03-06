#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(LEEF)


# Some setup action -------------------------------------------------------

root <- file.path("~", "LEEF")
dir.create(root)
setwd(root)
sapply(
    file.path(
        ".",
        "000.NewData",
        c("bemovi", "flowcam", "flowcytometer", "manualcount", "o2meter")
    ),
    dir.create,
    recursive = TRUE,
    showWarnings = FALSE
)


# Define UI for application
shinyUI(
    fluidPage(

        # Application title
        titlePanel("Control Centre for LEEF Pipeline"),

        # Sidebar with a slider input for number of bins
        sidebarLayout(
            # Sidebar panel for inputs ----
            sidebarPanel(
                width = 13,

                tabsetPanel(
                    type = "tabs",
                    selected = 1,
                    tabPanel(
                        "Initialize",
                        fileInput("configfile", label = shiny::h4("Config File")),
                        verbatimTextOutput("configfilename", placeholder = TRUE),
                        actionButton("initialize", label = "Initialize")
                    ),
                    tabPanel(
                        "Bemovi",
                        ##
                        shiny::h4("Files left to import"),
                        verbatimTextOutput("files_bemovi_input", placeholder = TRUE),
                        ##
                        actionButton("new_data_bemovi", label = "Import new Data"),
                        verbatimTextOutput("new_data_bemovi_result", placeholder = TRUE),
                        ##
                        shiny::h4("Files in raw data folder"),
                        verbatimTextOutput("files_bemovi_output", placeholder = TRUE),
                        ##
                        shiny::h4("Can Raw data be processed"),
                        verbatimTextOutput("ok_bemovi_output", placeholder = TRUE),
                        ##
                        shiny::h4("When done and Raw Data can be Processed, extract points"),
                        actionButton("extract_points_bemovi", label = "Extract Points"),
                        verbatimTextOutput("extract_points_bemovi_result", placeholder = TRUE)
                    ),
                    tabPanel(
                        "Flowcam",
                        ##
                        shiny::h4("Files left to import"),
                        verbatimTextOutput("files_flowcam_input", placeholder = TRUE),
                        ##
                        actionButton("new_data_flowcam", label = "Import new Data"),
                        verbatimTextOutput("new_data_flowcam_result", placeholder = TRUE),
                        ##
                        shiny::h4("Files in raw data folder"),
                        verbatimTextOutput("files_flowcam_output", placeholder = TRUE),
                        ##
                        shiny::h4("Can Raw data be processed"),
                        verbatimTextOutput("ok_flowcam_output", placeholder = TRUE)
                    ),
                    tabPanel(
                        "Flowcytometer",
                        ##
                        shiny::h4("Files left to import"),
                        verbatimTextOutput("files_flowcytometer_input", placeholder = TRUE),
                        ##
                        actionButton("new_data_flowcytometer", label = "Import new Data"),
                        verbatimTextOutput("new_data_flowcytometer_result", placeholder = TRUE),
                        ##
                        shiny::h4("Files in raw data folder"),
                        verbatimTextOutput("files_flowcytometer_output", placeholder = TRUE),
                        ##
                        shiny::h4("Can Raw data be processed"),
                        verbatimTextOutput("ok_flowcytometer_output", placeholder = TRUE)
                    ),
                    tabPanel(
                        "Manualcount",
                        ##
                        shiny::h4("Files left to import"),
                        verbatimTextOutput("files_manualcount_input", placeholder = TRUE),
                        ##
                        actionButton("new_data_manualcount", label = "Import new Data"),
                        verbatimTextOutput("new_data_manualcount_result", placeholder = TRUE),
                        ##
                        shiny::h4("Files in raw data folder"),
                        verbatimTextOutput("files_manualcount_output", placeholder = TRUE),
                        ##
                        shiny::h4("Can Raw data be processed"),
                        verbatimTextOutput("ok_manualcount_output", placeholder = TRUE)

                    ),
                    tabPanel(
                        "o2meter",
                        ##
                        shiny::h4("Files left to import"),
                        verbatimTextOutput("files_o2meter_input", placeholder = TRUE),
                        ##
                        actionButton("new_data_o2meter", label = "Import new Data"),
                        verbatimTextOutput("new_data_o2meter_result", placeholder = TRUE),
                        ##
                        shiny::h4("Files in raw data folder"),
                        verbatimTextOutput("files_o2meter_output", placeholder = TRUE),
                        ##
                        shiny::h4("Can Raw data be processed"),
                        verbatimTextOutput("ok_o2meter_output", placeholder = TRUE)

                    ),

                    # Queue Processing --------------------------------------------------------
                    tabPanel(
                        "Process All Data"
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
