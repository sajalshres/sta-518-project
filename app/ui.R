## ui.R ##

library(tidyverse)
# https://rstudio.github.io/DT/
library(DT)
# https://shiny.rstudio.com/articles/basics.html
library(shiny)
# https://rstudio.github.io/shinydashboard/get_started.html
library(shinydashboard)
# https://github.com/dreamRs/shinyWidgets
library(shinyWidgets)
# https://github.com/RinteRface/shinydashboardPlus
library(shinydashboardPlus)
# https://github.com/JohnCoene/waiter
library(waiter)
# https://rstudio.github.io/leaflet/
library(leaflet)

## Read components
source("components/header.R")
source("components/sidebar.R")
## Read views
source("views/dashboard.R")
source("views/data.R")

# Body content of the dashboard
body <- dashboardBody(
  tags$head(tags$style(
    HTML(
      "
      .sw-dropdown-in {
        padding: 0px 0px !important;
      }
    "
    )
  )),
  tabItems( # Dashboard tab
    dashboardItem(),

    # Data tab
    dataItem()
  )
)

# UI object that includes all the components
ui <- dashboardPage(
  md = FALSE,
  skin = "blue-light",
  preloader = list(html = tagList(spin_5(), "Loading app ..."), color = "#3c8dbc"),
  header = header,
  sidebar = sidebar,
  body = body,
)
