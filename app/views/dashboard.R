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
    width = 8,
    leafletOutput("mapPrice", height = 500)
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
