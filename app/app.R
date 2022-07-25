## app.R ##
library(DT)
library(modules)
library(tidyverse)

library(shiny)
library(shinydashboard)

source("ui.R")
source("modules/maps.R")

server <- function(input, output) {
  set.seed(518)
  
  load("../data/processed/chicago.Rda")
  
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
  
  output$mapPrice <- renderLeaflet({
    mapsListingsPrice(listings = chicago_listings)
  })
  
  output$dataTableListings <- renderDataTable({
    chicago_listings %>%
      select(
        id, 
        name, 
        neighbourhood,
        room_type,
        accommodates,
        bedrooms,
        beds,
        bathrooms,
        price
      )
  })
  
  output$dataTableHosts <- renderDataTable({
    chicago_listings %>%
      select(
        id, 
        host_id,
        host_name,
        host_since,
        host_neighbourhood,
        host_response_time,
        host_response_rate,
        host_is_superhost
      ) %>%
      distinct(host_id, .keep_all = TRUE)
  })
}

shinyApp(ui, server)