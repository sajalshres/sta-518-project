## sidebar.R ##

# Sidebar for the dashboard
sidebar <- dashboardSidebar(
  selectInput(
    "city",
    NULL,
    c(
      "Chicago" = "chicago",
      "New York" = "new-york"
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