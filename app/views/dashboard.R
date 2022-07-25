library(shinydashboard)

infoItems <- fluidRow(
  valueBox(6000, "Listings", icon = icon("building"), width = 3),
  valueBox(200, "Hosts", icon = icon("user"), color = "purple", width = 3),
  valueBox(50, "Neighbourhoods", icon = icon("map"), color = "orange", width = 3),
  valueBox(50000, "Reviews", icon = icon("star"), color = "green", width = 3),
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
