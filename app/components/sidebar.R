## sidebar.R ##

# Sidebar for the dashboard
sidebar <- dashboardSidebar(
  selectInput(
    "city",
    NULL,
    c(
      "Chicago" = "chicago",
      "Boston" = "boston",
      "Dallas" = "dallas",
      "Denver" = "denver",
      "Hawaii" = "hawaii",
      "New York City" = "new-york-city",
      "Los Angeles" = "los-angeles",
      "Washington Dc" = "washington-dc",
      "Asheville" = "asheville",
      "Austin" = "austin",
      "Broward County" = "broward-county",
      "Cambridge" = "cambridge",
      "Clark County Nv" = "clark-county-nv",
      "Columbus" = "columbus",
      "Fort Worth" = "fort-worth",
      "Jersey City" = "jersey-city",
      "Nashville" = "nashville",
      "New Orleans" = "new-orleans",
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
      "Twin Cities Msa" = "twin-cities-msa"
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
