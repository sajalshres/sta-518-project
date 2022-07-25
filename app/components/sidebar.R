## sidebar.R ##

# Sidebar for the dashboard
sidebar <- dashboardSidebar(
  selectInput(
    "city",
    NULL,
    c(
      "Chicago" = "chicago",
      "Asheville" = "asheville",
      "Austin" = "austin",
      "Boston" = "boston",
      "Broward County" = "broward-county",
      "Cambridge" = "cambridge",
      "Clark County Nv" = "clark-county-nv",
      "Columbus" = "columbus",
      "Dallas" = "dallas",
      "Denver" = "denver",
      "Fort Worth" = "fort-worth",
      "Hawaii" = "hawaii",
      "Jersey City" = "jersey-city",
      "Los Angeles" = "los-angeles",
      "Nashville" = "nashville",
      "New Orleans" = "new-orleans",
      "New York City" = "new-york-city",
      "Newark" = "newark",
      "Oakland" = "oakland",
      "Pacific Grove" = "pacific-grove",
      "Portland" = "portland",
      "Rhode Island" = "rhode-island",
      "Salem Or" = "salem-or",
      "San Diego" = "san-diego",
      "San Francisco" = "san-francisco",
      "San Mateo County" = "san-mateo-county",
      "Santa Clara County" = "santa-clara-county",
      "Santa Cruz County" = "santa-cruz-county",
      "Seattle" = "seattle",
      "Twin Cities Msa" = "twin-cities-msa",
      "Washington Dc" = "washington-dc"
    )
  ),
  sidebarMenu(
    menuItem(
      "Dashboard",
      tabName = "dashboard",
      icon = icon("flipboard")
    ),
    menuItem("Data", tabName = "data", icon = icon("table"))
  )
)