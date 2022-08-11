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

server <- function(input, output, session) {
  set.seed(518)

  # Create waiter
  waiter <-
    Waiter$new(
      html = tagList(spin_5(), "Loading app ..."),
      color = "#3c8dbc"
    )
  waiterMap <-
    Waiter$new("map-leaflet-id",
      html = tagList(spin_2(), "Updating map ..."),
      color = "#3c8dbc"
    )

  # Reactive listings data
  listings <- reactive({
    waiter$show()

    on.exit({
      waiter$hide()
    })

    loadListingsData(city = input$city)
  })

  # Reactive reviews data
  reviews <- reactive({
    loadReviewsData(city = input$city)
  })

  observeEvent(listings(), {
    updatePickerInput(
      session = session,
      inputId = "mapNeighbourhoodPickerInputId",
      choices = unique(listings()$neighbourhood),
      selected = unique(listings()$neighbourhood)
    )
    updatePickerInput(
      session = session,
      inputId = "mapRoomTypePickerInputId",
      choices = unique(listings()$room_type),
      selected = unique(listings()$room_type)
    )
    updateSliderTextInput(
      session = session,
      inputId = "mapPriceSliderInputId",
      choices = c(0, 50, 100, 150, 200, 250, 300, 400, 500, 1000, max(listings()$price)),
      selected = c(0, max(listings()$price))
    )
  })

  observeEvent(input$mapMarkerOpacitySliderInputId,
    {
      waiterMap$show()

      updateMapsListingsPrice(
        listings = listings(),
        neighbourhoods = input$mapNeighbourhoodPickerInputId,
        roomType = input$mapRoomTypePickerInputId,
        colorBy = input$mapColorPickerInputId,
        numOfBedrooms = input$mapBedroomRadioGroupButtonsId,
        numOfBathrooms = input$mapBathroomRadioGroupButtonsId,
        opacity = as.numeric(input$mapMarkerOpacitySliderInputId),
        size = input$mapMarkerSizeSliderInputId
      )

      Sys.sleep(0)

      waiterMap$hide()
    },
    ignoreNULL = FALSE,
    ignoreInit = TRUE
  )

  observeEvent(input$mapMarkerSizeSliderInputId,
    {
      waiterMap$show()

      updateMapsListingsPrice(
        listings = listings(),
        neighbourhoods = input$mapNeighbourhoodPickerInputId,
        roomType = input$mapRoomTypePickerInputId,
        colorBy = input$mapColorPickerInputId,
        numOfBedrooms = input$mapBedroomRadioGroupButtonsId,
        numOfBathrooms = input$mapBathroomRadioGroupButtonsId,
        opacity = as.numeric(input$mapMarkerOpacitySliderInputId),
        size = input$mapMarkerSizeSliderInputId
      )

      Sys.sleep(0)

      waiterMap$hide()
    },
    ignoreNULL = FALSE,
    ignoreInit = TRUE
  )

  observeEvent(input$mapPriceSliderInputId,
    {
      waiterMap$show()

      priceRange <<- input$mapPriceSliderInputId

      updateMapsListingsPrice(
        listings = listings(),
        neighbourhoods = input$mapNeighbourhoodPickerInputId,
        roomType = input$mapRoomTypePickerInputId,
        priceRange = input$mapPriceSliderInputId,
        colorBy = input$mapColorPickerInputId,
        numOfBedrooms = input$mapBedroomRadioGroupButtonsId,
        numOfBathrooms = input$mapBathroomRadioGroupButtonsId,
        opacity = as.numeric(input$mapMarkerOpacitySliderInputId),
        size = input$mapMarkerSizeSliderInputId
      )


      Sys.sleep(0)

      waiterMap$hide()
    },
    ignoreNULL = FALSE,
    ignoreInit = TRUE
  )

  observeEvent(input$mapNeighbourhoodPickerInputId,
    {
      waiterMap$show()

      updateMapsListingsPrice(
        listings = listings(),
        neighbourhoods = input$mapNeighbourhoodPickerInputId,
        roomType = input$mapRoomTypePickerInputId,
        colorBy = input$mapColorPickerInputId,
        numOfBedrooms = input$mapBedroomRadioGroupButtonsId,
        numOfBathrooms = input$mapBathroomRadioGroupButtonsId,
        opacity = as.numeric(input$mapMarkerOpacitySliderInputId),
        size = input$mapMarkerSizeSliderInputId
      )

      Sys.sleep(0)

      waiterMap$hide()
    },
    ignoreNULL = FALSE,
    ignoreInit = TRUE
  )

  observeEvent(input$mapColorPickerInputId,
    {
      waiterMap$show()

      updateMapsListingsPrice(
        listings = listings(),
        neighbourhoods = input$mapNeighbourhoodPickerInputId,
        roomType = input$mapRoomTypePickerInputId,
        colorBy = input$mapColorPickerInputId,
        numOfBedrooms = input$mapBedroomRadioGroupButtonsId,
        numOfBathrooms = input$mapBathroomRadioGroupButtonsId,
        opacity = as.numeric(input$mapMarkerOpacitySliderInputId),
        size = input$mapMarkerSizeSliderInputId
      )

      Sys.sleep(0)

      waiterMap$hide()
    },
    ignoreNULL = FALSE,
    ignoreInit = TRUE
  )

  observeEvent(input$mapRoomTypePickerInputId,
    {
      waiterMap$show()

      updateMapsListingsPrice(
        listings = listings(),
        neighbourhoods = input$mapNeighbourhoodPickerInputId,
        roomType = input$mapRoomTypePickerInputId,
        colorBy = input$mapColorPickerInputId,
        numOfBedrooms = input$mapBedroomRadioGroupButtonsId,
        numOfBathrooms = input$mapBathroomRadioGroupButtonsId,
        opacity = as.numeric(input$mapMarkerOpacitySliderInputId),
        size = input$mapMarkerSizeSliderInputId
      )

      Sys.sleep(0)

      waiterMap$hide()
    },
    ignoreNULL = FALSE,
    ignoreInit = TRUE
  )

  observeEvent(input$mapBedroomRadioGroupButtonsId,
    {
      waiterMap$show()

      updateMapsListingsPrice(
        listings = listings(),
        neighbourhoods = input$mapNeighbourhoodPickerInputId,
        roomType = input$mapRoomTypePickerInputId,
        colorBy = input$mapColorPickerInputId,
        numOfBedrooms = input$mapBedroomRadioGroupButtonsId,
        numOfBathrooms = input$mapBathroomRadioGroupButtonsId,
        opacity = as.numeric(input$mapMarkerOpacitySliderInputId),
        size = input$mapMarkerSizeSliderInputId
      )

      Sys.sleep(0)

      waiterMap$hide()
    },
    ignoreNULL = TRUE,
    ignoreInit = TRUE
  )

  observeEvent(input$mapBathroomRadioGroupButtonsId,
    {
      waiterMap$show()

      updateMapsListingsPrice(
        listings = listings(),
        neighbourhoods = input$mapNeighbourhoodPickerInputId,
        roomType = input$mapRoomTypePickerInputId,
        colorBy = input$mapColorPickerInputId,
        numOfBedrooms = input$mapBedroomRadioGroupButtonsId,
        numOfBathrooms = input$mapBathroomRadioGroupButtonsId,
        opacity = as.numeric(input$mapMarkerOpacitySliderInputId),
        size = input$mapMarkerSizeSliderInputId
      )

      Sys.sleep(0)

      waiterMap$hide()
    },
    ignoreNULL = TRUE,
    ignoreInit = TRUE
  )

  observeEvent(input$mapResetButtonId,
    {
      updatePickerInput(
        session = session,
        inputId = "mapNeighbourhoodPickerInputId",
        choices = unique(listings()$neighbourhood),
        selected = unique(listings()$neighbourhood)
      )
      updatePickerInput(
        session = session,
        inputId = "mapRoomTypePickerInputId",
        choices = unique(listings()$room_type),
        selected = unique(listings()$room_type)
      )
      updateRadioGroupButtons(
        session = session,
        inputId = "mapBedroomRadioGroupButtonsId",
        selected = character(0)
      )
      updateRadioGroupButtons(
        session = session,
        inputId = "mapBathroomRadioGroupButtonsId",
        selected = character(0)
      )
    },
    ignoreInit = TRUE
  )

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

    anaylzeNeighbourhoodsByPrice(listings(),
      order = order,
      limit = input$neighbourhoodCountInputId
    )
  })

  # UI Dashboard: Room Type Proportion -------------------------------------------------------------
  output$analyzeRoomTypeProportion <- renderPlot({
    analyzeRoomTypeProportion(listings = listings())
  })

  # UI Dashboard: Room Type Distribution -----------------------------------------------------------
  output$analyzeRoomTypeDistribution <- renderPlot({
    analyzeRoomTypeDistribution(listings = listings())
  })

  # UI Dashboard: Distribution By Price ------------------------------------------------------------
  output$analyzeDistributionByPrice <- renderPlot({
    analyzeDistributionByPrice(listings = listings())
  })

  # UI Dashboard: Most Common Words ----------------------------------------------------------------
  output$analyzeMostCommonWords <- renderPlot({
    analyzeMostCommonWords(names = listings()$name)
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
