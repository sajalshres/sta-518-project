## data.R ##
library(plumber)
library(tidyverse)


#* Echo back the input
#* @get /listings
#* @param city Name of the city
#* @tag data
data <- function(city="chicago"){
  print(list.dirs("../"))
  listings <- readRDS(paste0("../data/processed/", city, "_listings.Rds"))
  listings
}