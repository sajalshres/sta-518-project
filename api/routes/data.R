## data.R ##

## Read modules
# Includes a function that paginates the large responses
source("../modules/paginate.R")

#* Get available cities by code
#* @get /cities
#* @tag data
get_cities <- function(res) {
  # Read listing object by city
  scrape_info <- readRDS("data/scrape_info.Rds")
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
    readRDS(paste0("data/", city, "_listings.Rds"))
  
  listings <- listings %>%
    select(id,
           name,
           neighbourhood,
           room_type,
           accommodates,
           bedrooms,
           beds,
           bathrooms,
           price)
  
  return(paginate_data(res, df = listings, page = as.integer(page)))
}

#* Get the Airbnb hosts data for requested city
#* @get /hosts
#* @param city Name of the city
#* @tag data
get_hosts <- function(res, city = "chicago", page = 1) {
  # Read listing object by city
  listings <-
    readRDS(paste0("data/", city, "_listings.Rds"))
  
  hosts <- listings %>%
    select(
      id,
      host_id,
      host_name,
      host_since,
      host_neighbourhood,
      host_response_time,
      host_response_rate,
      host_is_superhost
    ) %>%
    distinct(host_id, .keep_all = TRUE)
  
  return(paginate_data(res, df = hosts, page = as.integer(page)))
}

#* Get the Airbnb reviews data for requested city
#* @get /reviews
#* @param city Name of the city
#* @tag data
get_reviews <- function(res, city = "chicago", page = 1) {
  # Read listing object by city
  reviews <-
    readRDS(paste0("data/", city, "_reviews.Rds"))
  
  return(paginate_data(
    res,
    df = reviews,
    page_size = 100,
    page = as.integer(page)
  ))
}