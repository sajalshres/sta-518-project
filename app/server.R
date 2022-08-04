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

  # Create waiter
  waiter <- Waiter$new(html = tagList(spin_5(), "Loading app ..."), color = "#3c8dbc")

  # Reactive listings data
  listings <- reactive({
    waiter$show()

    on.exit({
      Sys.sleep(1)
      waiter$hide()
    })

    loadListingsData(city = input$city)
  })

  # Reactive reviews data
  reviews <- reactive({
    loadReviewsData(city = input$city)
  })

  # UI Dashboard: Info -----------------------------------------------------------------------------
  # Output listings count
  output$valueBoxListings <- renderValueBox({
    valueBox(prettyNum(nrow(listings()), big.mark = ","),
      "Listings",
      icon = icon("building"),
    )
  })

  # Output hosts count
  output$valueBoxHosts <- renderValueBox({
    valueBox(
      prettyNum(n_distinct(listings()$host_id), big.mark = ","),
      "Hosts",
      icon = icon("user"),
      color = "purple",
    )
  })

  # Output neighborhoods count
  output$valueBoxNeighbourhoods <- renderValueBox({
    valueBox(
      n_distinct(listings()$neighbourhood),
      "Neighbourhoods",
      icon = icon("map"),
      color = "orange",
    )
  })

  # Output reviews count
  output$valueBoxReviews <- renderValueBox({
    valueBox(
      prettyNum(nrow(reviews()), big.mark = ","),
      "Reviews",
      icon = icon("star"),
      color = "green",
    )
  })

  # UI Dashboard: Maps Box -------------------------------------------------------------------------
  output$mapPrice <- renderLeaflet({
    mapsListingsPrice(listings = listings())
  })

  # UI Dashboard: Room Type Proportion -------------------------------------------------------------
  output$analyzeRoomTypeProportion <- renderPlot({
    analyzeRoomTypeProportion(listings = listings())
  })

  # UI Dashboard: Room Type Proportion -------------------------------------------------------------
  output$analyzeRoomTypeDistribution <- renderPlot({
    analyzeRoomTypeDistribution(listings = listings())
  })

  # UI Dashboard: Top Hosts Box --------------------------------------------------------------------
  output$analyzeTopHostsPlot <- renderPlot({
    analyzeTopHosts(listings())
  })

  # UI Dashboard: Neighborhood Price Box -----------------------------------------------------------
  output$analyzeNeighbourhoodByPricePlot <- renderPlot({
    order <- "desc"
    if (input$neighbourhoodPriceInputId == "Least Expensive") {
      order <- "asc"
    }

    anaylzeNeighbourhoodsByPrice(listings(), order = order, limit = input$neighbourhoodCountInputId)
  })

  # UI Data: Listings Data Table -------------------------------------------------------------------
  output$dataTableListings <- DT::renderDataTable({
    listings() %>%
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

  # UI Data: Hosts Data Table ----------------------------------------------------------------------
  output$dataTableHosts <- DT::renderDataTable(
    {
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
