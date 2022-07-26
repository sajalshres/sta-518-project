## app.R ##
library(shiny)

source("ui.R")
source("server.R")

# Run shiny web app
shinyApp(ui, server)
