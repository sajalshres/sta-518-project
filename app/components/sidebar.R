## sidebar.R ##

# Sidebar for the dashboard
sidebar <- dashboardSidebar(sidebarMenu(
  menuItem(
    "Dashboard",
    tabName = "dashboard",
    icon = icon("flipboard")
  ),
  menuItem("Data", tabName = "data", icon = icon("table"))
))