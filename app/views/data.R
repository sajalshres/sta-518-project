
library(shinydashboard)

titleItem <- fluidRow(h2("Raw Data"))

dataItem <- function() {
  return(
    tabItem(
      tabName = "data",
      titleItem
    )
  )
}