library(DT)
library(shinydashboard)

listingItem <- fluidRow(
  box(dataTableOutput("dataTableListings"), title = "Listings Data", width = 12)
)

hostItem <- fluidRow(
  box(dataTableOutput("dataTableHosts"), title = "Hosts Data", width = 12)
)

dataItem <- function() {
  return(
    tabItem(
      tabName = "data",
      listingItem,
      hostItem
    )
  )
}