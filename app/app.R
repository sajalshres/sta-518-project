## app.R ##

# https://shiny.rstudio.com/articles/basics.html
library(shiny)

source("ui.R")
source("server.R")

# Run shiny web app
shinyApp(ui, server)
