library(shinydashboard)

infoItems <- fluidRow(
  valueBoxOutput("valueBoxListings", width = 3),
  valueBoxOutput("valueBoxHosts", width = 3),
  valueBoxOutput("valueBoxNeighbourhoods", width = 3),
  valueBoxOutput("valueBoxReviews", width = 3),
)

sampleDashboardItems <- fluidRow(
  box(plotOutput("plot1", height = 400)),
  box(plotOutput("plot2", height = 400)),
  box(plotOutput("plot3", height = 400)),
  box(plotOutput("plot4", height = 400)),
)

mapItems <- fluidRow(
  box(leafletOutput("mapPrice"))
)

dashboardItem <- function() {
  return(
    tabItem(
      tabName = "dashboard",
      infoItems,
      sampleDashboardItems,
      mapItems
    )
  )
}
