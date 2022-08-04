## ui.R ##

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
