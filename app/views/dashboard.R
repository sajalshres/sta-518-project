library(shinydashboard)

infoItems <- fluidRow(
  valueBox(6000, "Listings", icon = icon("building")),
  valueBox(200, "Hosts", icon = icon("user"), color = "purple"),
  valueBox(50, "Neighbourhoods", icon = icon("map"), color = "orange"),
  valueBox(50000, "Reviews", icon = icon("star"), color = "green"),
)

sampleDashboardItems <- fluidRow(
  box(plotOutput("plot1", height = 400)),
  box(plotOutput("plot2", height = 400)),
  box(plotOutput("plot3", height = 400)),
  box(plotOutput("plot4", height = 400)),
)

dashboardItem <- function() {
  return(
    tabItem(
      tabName = "dashboard",
      infoItems,
      sampleDashboardItems
    )
  )
}
