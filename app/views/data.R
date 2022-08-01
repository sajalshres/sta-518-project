## data.R ##

listingItem <- fluidRow(
  box(DT::dataTableOutput("dataTableListings"), title = "Listings Data", width = 12)
)

hostItem <- fluidRow(
  box(DT::dataTableOutput("dataTableHosts"), title = "Hosts Data", width = 12)
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