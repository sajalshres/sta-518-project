## dashboard.R ##

# Row: summary info
infoItems <- fluidRow(
  valueBoxOutput("valueBoxListings", width = 3),
  valueBoxOutput("valueBoxHosts", width = 3),
  valueBoxOutput("valueBoxNeighbourhoods", width = 3),
  valueBoxOutput("valueBoxReviews", width = 3),
)

# Row: map widgets
mapItems <- fluidRow(
  box(
    title = "Explore Maps",
    width = 12,
    div(
      class = "map-box-row",
      div(id = "map-leaflet-id", class = "map-leaflet-container", leafletOutput("mapPrice", width = "100%", height = 700)),
      div(
        class = "map-controls-container",
        sliderInput(
          inputId = "mapMarkerOpacitySliderInputId",
          label = "Marker Opacity",
          min = 0,
          max = 1,
          value = 1,
          step = .1
        ),
        sliderInput(
          inputId = "mapMarkerSizeSliderInputId",
          label = "Marker Size",
          min = 0,
          max = 10,
          value = 3,
          step = 1
        ),
        sliderTextInput(
          inputId = "mapPriceSliderInputId",
          label = "Price Range",
          choices = c(0, 50, 100, 150, 200, 250, 300, 400, 500, 1000, 10000),
          selected = c(0, 100),
          grid = TRUE
        ),
        pickerInput(
          inputId = "mapNeighbourhoodPickerInputId",
          label = "Neighbourhood",
          choices = NULL,
          multiple = TRUE,
          width = "100%",
          options = list(
            `actions-box` = TRUE,
            `none-selected-text` = "None"
          ),
          inline = FALSE
        ),
        pickerInput(
          inputId = "mapColorPickerInputId",
          label = "Color By",
          choices = c("Price", "Room Type"),
          width = "100%",
          inline = FALSE
        ),
        pickerInput(
          inputId = "mapRoomTypePickerInputId",
          label = "Room Type",
          choices = NULL,
          multiple = TRUE,
          width = "100%",
          options = list(
            `actions-box` = TRUE,
            `none-selected-text` = "None"
          ),
          inline = FALSE
        ),
        radioGroupButtons(
          inputId = "mapBedroomRadioGroupButtonsId",
          label = "Bedrooms",
          choices = c(
            "1",
            "2", "3", "4", "5+"
          ),
          selected = character(0),
          justified = TRUE
        ),
        radioGroupButtons(
          inputId = "mapBathroomRadioGroupButtonsId",
          label = "Bathrooms",
          choices = c(
            "1+",
            "2+", "3+", "4+"
          ),
          selected = character(0),
          justified = TRUE
        ),
        actionButton(
          inputId = "mapResetButtonId",
          label = "Reset Filters",
          style = "simple",
          icon = icon("rotate")
        )
      )
    )
  )
)

# Row: analyze room type
roomTypeItems <- fluidRow(
  box(
    title = "Room Type Proportion",
    plotOutput("analyzeRoomTypeProportion", height = 500)
  ),
  box(
    title = "Room Type Distribution",
    plotOutput("analyzeRoomTypeDistribution", height = 500)
  )
)

anaylzeItems <-
  fluidRow(
    box(
      title = "Top Hosts",
      plotOutput("analyzeTopHostsPlot", height = 500)
    ),
    box(
      title = "Top Neighbourhoods By Price",
      sidebar = boxSidebar(
        id = "mycardsidebar",
        width = 40,
        icon = icon("gear"),
        pickerInput(
          inputId = "neighbourhoodPriceInputId",
          choices = c("Most Expensive", "Least Expensive"),
          choicesOpt = list(
            icon = c(
              "glyphicon glyphicon-arrow-up",
              "glyphicon glyphicon-arrow-down"
            )
          ),
          width = "98%",
          inline = TRUE
        ),
        sliderInput(
          inputId = "neighbourhoodCountInputId",
          label = "Neighbourhood Count",
          min = 5,
          max = 20,
          value = 10,
          step = 5
        )
      ),
      plotOutput("analyzeNeighbourhoodByPricePlot", height = 500)
    )
  )



dashboardItem <- function() {
  return(tabItem(
    tabName = "dashboard",
    infoItems,
    mapItems,
    roomTypeItems,
    anaylzeItems,
  ))
}
