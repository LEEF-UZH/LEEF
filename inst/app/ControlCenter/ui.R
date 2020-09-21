#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

sapply(
    file.path("~", "LEEF", "000.NewData", c("bemovi", "flowcam", "flowcytometer", "incubatortemp", "manualcount", "o2meter", "toc")),
    dir.create,
    recursive = TRUE,
    showWarnings = FALSE
)
setwd("~/LEEF")

# Define UI for application that draws a histogram
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
                        verbatimTextOutput("ok_bemovi_output", placeholder = TRUE)
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
                        "Incubator temp",
                        ##
                        shiny::h4("Files left to import"),
                        verbatimTextOutput("files_incubatortemp_input", placeholder = TRUE),
                        ##
                        actionButton("new_data_incubatortemp", label = "Import new Data"),
                        verbatimTextOutput("new_data_incubatortemp_result", placeholder = TRUE),
                        ##
                        shiny::h4("Files in raw data folder"),
                        verbatimTextOutput("files_incubatortemp_output", placeholder = TRUE),
                        ##
                        shiny::h4("Can Raw data be processed"),
                        verbatimTextOutput("ok_incubatortemp_output", placeholder = TRUE)

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
                    tabPanel(
                        "TOC",
                        ##
                        shiny::h4("Files left to import"),
                        verbatimTextOutput("files_toc_input", placeholder = TRUE),
                        ##
                        actionButton("new_data_toc", label = "Import new Data"),
                        verbatimTextOutput("new_data_toc_result", placeholder = TRUE),
                        ##
                        shiny::h4("Files in raw data folder"),
                        verbatimTextOutput("files_toc_output", placeholder = TRUE),
                        ##
                        shiny::h4("Can Raw data be processed"),
                        verbatimTextOutput("ok_toc_output", placeholder = TRUE)

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
