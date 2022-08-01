## server.R ##

# Read modules
source("modules/maps.R")
source("modules/analyze.R")

# Dynamically load listings data for reactivity
loadListingsData <- function(city) {
  listings <- readRDS(paste0("data/", city, "_listings.Rds"))
  return(listings)
}

# Dynamically load reviews data for reactivity
loadReviewsData <- function(city) {
  reviews <- readRDS(paste0("data/", city, "_reviews.Rds"))
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
  
  output$valueBoxListings <- renderValueBox({
    valueBox(prettyNum(nrow(listings()), big.mark = ","),
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
  
  output$mapPrice <- renderLeaflet({
    mapsListingsPrice(listings = listings())
  })
  
  output$analyzeTopHostsPlot <- renderPlot({
    analyzeTopHosts(listings())
  })
  
  output$analyzeNeighbourhoodByPricePlot <- renderPlot({
    order <- "desc"
    if (input$neighbourhoodPriceInputId == "Least Expensive") {
      order <- "asc"
    }
    
    anaylzeNeighbourhoodsByPrice(listings(), order = order, limit = input$neighbourhoodCountInputId)
  })
  
  output$dataTableListings <- DT::renderDataTable({
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
  
  output$dataTableHosts <- DT::renderDataTable({
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
  },
  server = FALSE
  )
}