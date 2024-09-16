library("shiny")
library("ggpattern")
library("shinydashboard")
library("shinyWidgets")
library("ggplot2")
library("ggthemes")
library("bslib")
library("dplyr")
library("data.table")
library("reactable")
library("tidyr")
library("ggtext")
source("R/visualisation.R")

custom_theme <- bs_theme(
  version = 5,
  bg = "#FFFFFF",
  fg = "#000000",
  primary = "#E3E3E3",
  secondary = "#000000",
  base_font = "Maven Pro"
)

data <- fread(file = "datas/owid-energy-data-sorted.csv",
              head = TRUE, 
              fill = TRUE,
              sep = ",")  
print(data)

ui <- fluidPage(
  title = "energy-app",
  theme = custom_theme,
  tags$head(
    tags$link(rel = "icon", type = "image/png", sizes = "32x32", href = "rings.png")
  ),
  fluidRow(
    class = "mt-4",
    column(width = 12,
      column(
             width = 4,
             virtualSelectInput(inputId = "country",
                          ,
                          label = "select countries",
                          choices = unique(data$country),
                          multiple = TRUE,
                          selected = "France",
                          width = "100%"
             )
      ),
      column(
             width = 4,
             sliderInput(inputId = "year",
                          ,
                          label = "select a year range",
                          value = c((max(data$year) - 10),
                                    max(data$year)),
                          min = min(data$year),
                          max = max(data$year),
                          width = "100%",
                          step = 1,
                          sep = NULL
             )
      )
    ),
    plotOutput("plot")
  )
)

server <- function(input, output){
  data_in <- reactive({
    data <- data %>%
            filter(country %in% input$country, 
                   year %in% input$year)
  })
  output$plot <- {
    output$plot <- renderPlot(pie_plot(data_in()))
  }
}

shinyApp(ui = ui, server = server)


