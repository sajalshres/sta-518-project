## ui.R ##

# https://rstudio.github.io/shinydashboard
library(leaflet)
library(shinydashboard)

source("components/header.R")
source("components/sidebar.R")
source("views/dashboard.R")
source("views/data.R")

# Body content of the dashboard
body <- dashboardBody(
  tabItems(
    # Dashboard tab
    dashboardItem(),
    
    # Data tab
    dataItem()
  )
)

# UI object that includes all the components
ui <- dashboardPage(
  skin = "blue",
  header = header,
  sidebar = sidebar,
  body = body
)
