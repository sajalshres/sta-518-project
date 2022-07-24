## ui.R ##

# https://rstudio.github.io/shinydashboard
library(shinydashboard)

source("components/header.R")
source("components/sidebar.R")

infoItems <- fluidRow(
  valueBox(6000, "Listings", icon = icon("building")),
  valueBox(200, "Hosts", icon = icon("user"), color = "purple"),
  valueBox(50, "Neighbourhoods", icon = icon("map"), color = "orange"),
  valueBox(50000, "Reviews", icon = icon("star"), color = "green"),
)

sampleDashboardItems <- fluidRow(
  box(plotOutput("plot1", height = 250)),
  box(
   title = "Controls",
   sliderInput("slider", "Number of observations:", 1, 100, 50)
  )
)

# Body content of the dashboard
body <- dashboardBody(
  tabItems(
    # First tab content
    tabItem(
      tabName = "dashboard",
      infoItems,
      sampleDashboardItems
    ),
    # Second tab content
    tabItem(
      tabName = "widgets",
      h2("Widgets tab content")
    )
  )
)

# UI object that includes all the components
ui <- dashboardPage(
  skin = "blue",
  header = header,
  sidebar = sidebar,
  body = body
)
