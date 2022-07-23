## sidebar.R ##

# Sidebar for the dashboard
sidebar <- dashboardSidebar(sidebarMenu(
  menuItem(
    "Dashboard",
    tabName = "dashboard",
    icon = icon("dashboard")
  ),
  menuItem("Widgets", tabName = "widgets", icon = icon("th"))
))