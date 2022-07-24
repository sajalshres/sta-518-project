## app.R ##
library(shiny)
library(shinydashboard)
library(tidyverse)
library(DT)

source("ui.R")

server <- function(input, output) {
  set.seed(518)
  
  data <- tibble::tibble(
    name = c("A", "B", "C", "D", "E") ,
    value = c(3, 12, 5, 18, 45))
  
  output$plot1 <- renderPlot({
    ggplot(data, aes(x = name, y = value)) +
      geom_bar(stat = "identity")
  })
  
  output$plot2 <- renderPlot({
    ggplot(iris, aes(x=Sepal.Length, y=Sepal.Width, color=Species)) + 
      geom_point(size=6)
  })
  
  output$plot3 <- renderPlot({
    ggplot(iris, aes(x=Sepal.Length, y=Sepal.Width, color=Species)) + 
      geom_point(size=6)
  })
  
  output$plot4 <- renderPlot({
    ggplot(iris, aes(x=Sepal.Length, y=Sepal.Width, color=Species)) + 
      geom_point(size=6)
  })
}

shinyApp(ui, server)