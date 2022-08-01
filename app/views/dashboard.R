## dashboard.R ##

infoItems <- fluidRow(
  valueBoxOutput("valueBoxListings", width = 3),
  valueBoxOutput("valueBoxHosts", width = 3),
  valueBoxOutput("valueBoxNeighbourhoods", width = 3),
  valueBoxOutput("valueBoxReviews", width = 3),
)

mapItems <- fluidRow(box(leafletOutput("mapPrice")))

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
          inputId = 'neighbourhoodCountInputId',
          label = 'Neighbourhood Count',
          min = 5,
          max = 20,
          value = 10,
          step = 5
        )
      ),
      plotOutput("analyzeNeighbourhoodByPricePlot", height = 520)
    ),
    column(
      width = 6,
      uiOutput("analyzeNeighbourhoodUI")
    )
)

sampleDashboardItems <-
  fluidRow(box(plotOutput("plot1", height = 400)),
           box(plotOutput("plot2", height = 400)),
           box(plotOutput("plot3", height = 400)),
           box(plotOutput("plot4", height = 400)),
  )



dashboardItem <- function() {
  return(tabItem(tabName = "dashboard",
                 infoItems,
                 mapItems,
                 anaylzeItems, ))
}
