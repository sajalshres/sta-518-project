library(DT)
library(shinydashboard)

dataItems <- fluidRow(
  box(dataTableOutput("dataTableListings"), width = 12)
)

dataItem <- function() {
  return(
    tabItem(
      tabName = "data",
      dataItems
    )
  )
}