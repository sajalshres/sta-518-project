## app.R ##
library(DT)
library(modules)
library(tidyverse)

library(shiny)
library(shinydashboard)

source("ui.R")
source("modules/maps.R")

loadListingsData <- function(city) {
 listings <- readRDS(paste0("data/processed/", city, "_listings.Rds"))
 return(listings)
}

loadReviewsData <- function(city) {
  reviews <- readRDS(paste0("data/processed/", city, "_reviews.Rds"))
  return(reviews)
}

server <- function(input, output) {
  set.seed(518)
  
  listings <- reactive({
    loadListingsData(city = input$city)
  })
  
  reviews <- reactive({
    loadReviewsData(city = input$city)
  })
  
  data <- tibble::tibble(name = c("A", "B", "C", "D", "E") ,
                         value = c(3, 12, 5, 18, 45))
  
  output$valueBoxListings <- renderValueBox({
    valueBox(
      prettyNum(nrow(listings()), big.mark = ","),
      "Listings",
      icon = icon("building"),
    )
  })
  
  output$valueBoxHosts <- renderValueBox({
    valueBox(
      prettyNum(n_distinct(listings()$host_id), big.mark = ","),
      "Hosts",
      icon = icon("user"),
      color = "purple",
    )
  })
  
  output$valueBoxNeighbourhoods <- renderValueBox({
    valueBox(
      n_distinct(listings()$neighbourhood),
      "Neighbourhoods",
      icon = icon("map"),
      color = "orange",
    )
  })
  
  output$valueBoxReviews <- renderValueBox({
    valueBox(
      prettyNum(nrow(reviews()), big.mark = ","),
      "Reviews",
      icon = icon("star"),
      color = "green",
    )
  })
  
  output$plot1 <- renderPlot({
    ggplot(data, aes(x = name, y = value)) +
      geom_bar(stat = "identity")
  })
  
  output$plot2 <- renderPlot({
    ggplot(iris, aes(x = Sepal.Length, y = Sepal.Width, color = Species)) +
      geom_point(size = 6)
  })
  
  output$plot3 <- renderPlot({
    ggplot(iris, aes(x = Sepal.Length, y = Sepal.Width, color = Species)) +
      geom_point(size = 6)
  })
  
  output$plot4 <- renderPlot({
    ggplot(iris, aes(x = Sepal.Length, y = Sepal.Width, color = Species)) +
      geom_point(size = 6)
  })
  
  output$mapPrice <- renderLeaflet({
    mapsListingsPrice(listings = listings())
  })
  
  output$dataTableListings <- renderDataTable({
    listings() %>%
      select(id,
             name,
             neighbourhood,
             room_type,
             accommodates,
             bedrooms,
             beds,
             bathrooms,
             price)
  })
  
  output$dataTableHosts <- renderDataTable({
    listings() %>%
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