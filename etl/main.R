## main.R ##

library(tidyverse)

## Read modules
source("modules/scrape.R")

# Global variables
data_dir <- "data"

process_listings <- function(file_path) {
  listings <- readr::read_csv(file_path)
  
  # Remove unwanted columns
  listings <- listings %>%
    select(
      id,
      name,
      description,
      host_id,
      host_name,
      host_since,
      host_location,
      host_about,
      host_response_time,
      host_response_rate,
      host_acceptance_rate,
      host_is_superhost,
      host_neighbourhood,
      host_verifications,
      host_identity_verified,
      host_has_profile_pic,
      neighbourhood_cleansed,
      latitude,
      longitude,
      property_type,
      room_type,
      accommodates,
      bathrooms_text,
      bedrooms,
      beds,
      price
    ) %>%
    mutate(host_since = format(as.Date(host_since), "%m/%d/%Y"),
           .after = host_name) %>%
    mutate(bathrooms = parse_number(str_extract(bathrooms_text, "\\d*\\.?\\d+")), .after = beds) %>%
    mutate(price = parse_number(price),) %>%
    select(!bathrooms_text) %>%
    rename(neighbourhood = neighbourhood_cleansed)
  
  # Replace empty values with NA
  listings[listings == ""] <- NA
  
  # Replace N/A values with NA
  listings[listings == "N/A"] <- NA
  
  # Drop rows with NA in id, name
  listings <- listings %>%
    drop_na(c("id", "name", "host_id", "host_name", "host_location", "host_neighbourhood"))

  listings <- listings %>%
    filter(
      host_location == names(which.max(table(host_location)))
    )
  
  return(listings)
}

process_reviews <- function(file_path) {
  reviews <- readr::read_csv(file_path)
  
  # drop na
  reviews %>%
    drop_na()
  
  return(reviews)
  
}

# Start Process
start_process <- function() {
  # Scrape the data
  scrape_info <- start_scrape()
  
  # save scrape
  saveRDS(scrape_info, "data/processed/scrape_info.Rds")
  
  for(city in unique(scrape_info$city)) {
    print(paste("Processing for", city))
    # Process listings
    listings <- process_listings(file_path = paste0("data/raw/", city, "_listings.csv.gz"))
    # Save listings data
    saveRDS(listings, paste0("data/processed/", city, "_listings.Rds"))
    
    # Process reviews
    reviews <- process_reviews(file_path = paste0("data/raw/", city, "_reviews.csv.gz"))
    # Save reviews data
    saveRDS(reviews, paste0("data/processed/", city, "_reviews.Rds"))
  }
}

start_process()
