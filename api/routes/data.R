## data.R ##
library(plumber)
library(tidyverse)

## Read modules
# Includes a function that paginates the large responses
source("../modules/paginate.R")

#* Get available cities by code
#* @get /cities
#* @tag data
get_cities <- function(res) {
  # Read listing object by city
  scrape_info <- readRDS("data/processed/scrape_info.Rds")
  return(unique(scrape_info$city))
}


#* Get summary of the Airbnb data for requested city
#* @get /summary
#* @param city Name of the city
#* @tag data
get_summary <- function(res, city = "chicago") {
  return(list(status = "TODO, implement in future"))
}

#* Get the Airbnb listings data for requested city
#* @get /listings
#* @param city Name of the city
#* @tag data
get_listings <- function(res, city = "chicago", page = 1) {
  # Read listing object by city
  listings <-
    readRDS(paste0("data/processed/", city, "_listings.Rds"))
  
  return(paginate_data(res, df = listings, page = as.integer(page)))
}

#* Get the Airbnb reviews data for requested city
#* @get /reviews
#* @param city Name of the city
#* @tag data
get_reviews <- function(res, city = "chicago", page = 1) {
  # Read listing object by city
  reviews <-
    readRDS(paste0("data/processed/", city, "_reviews.Rds"))
  
  return(paginate_data(
    res,
    df = reviews,
    page_size = 100,
    page = as.integer(page)
  ))
}