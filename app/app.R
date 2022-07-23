## app.R ##
library(shiny)
library(shinydashboard)

source("ui.R")

server <- function(input, output) {
  set.seed(518)
  histdata <- rnorm(500)
  
  output$plot1 <- renderPlot({
    data <- histdata[seq_len(input$slider)]
    hist(data)
  })
}

shinyApp(ui, server)