## ui.R ##

# https://rstudio.github.io/shinydashboard
library(shinydashboard)

# Header for the dashboard
header <- dashboardHeader(title = "Airbnb Analysis")

# Sidebar for the dashboard
sidebar <- dashboardSidebar(sidebarMenu(
  menuItem(
    "Dashboard",
    tabName = "dashboard",
    icon = icon("dashboard")
  ),
  menuItem("Widgets", tabName = "widgets", icon = icon("th"))
))

# Body content of the dashboard
body <- dashboardBody(tabItems(
  # First tab content
  tabItem(tabName = "dashboard",
          fluidRow(
            box(plotOutput("plot1", height = 250)),
            
            box(
              title = "Controls",
              sliderInput("slider", "Number of observations:", 1, 100, 50)
            )
          )),
  
  # Second tab content
  tabItem(tabName = "widgets",
          h2("Widgets tab content"))
))

# UI object that includes all the components
ui <- dashboardPage(header = header,
                    sidebar = sidebar,
                    body = body)
