library("rvest")

fetch_data <- function(country_name = "united-states") {
  base_url <- "http://data.insideairbnb.com"
  
  if (country_name == "") {
    stop("Paramaeter country_name is required.")
  }
  
  # Extract all the page data
  page_data <- read_html("http://insideairbnb.com/get-the-data")
  
  # Get all the links
  links <- page_data %>%
    html_elements("a") %>%
    html_attr("href")
  
  # Create a tibble data frame for data manipulation
  df <- tibble(links = links)
  
  # data manipulation
  df <- df %>%
    # filter the data by country
    filter(grepl(paste(base_url, country_name, sep = "/"), links)) %>%
    group_by(links) %>%
    # Add columns
    mutate(
      country = unlist(str_split(links, "/"))[4],
      state = unlist(str_split(links, "/"))[5],
      city = unlist(str_split(links, "/"))[6],
      date = unlist(str_split(links, "/"))[7],
      file_name = unlist(str_split(links, "/"))[9],
    ) %>%
    # Remove unwanted files
    filter(!(file_name %in% c("listings.csv", "reviews.csv"))) %>%
    arrange(state)
  
  # Return data frame
  return(df)
}

download_data <- function(link, city_name, file_name) {
  # result flag
  is_downloaded <- TRUE
  
  dest_file <- paste0("data/raw/", paste0(city_name, "_", file_name))
  
  # skip if file already exists
  if(file.exists(dest_file)) {
    print(paste0("Download skipped, reason: file ", dest_file, " already exists"))
    return(is_downloaded)
  }
  
  tryCatch(
    download.file(link, dest_file),
    # handle error
    error = function(error) {
      print(paste0("Error occurred when downloading file. reason: ", error))
      is_downloaded <<- FALSE
    }
  )
  
  return(is_downloaded)
}

start_scrape <- function() {
  # get the download data information
  data <- fetch_data()
  
  # download data
  data <- data %>%
    rowwise() %>%
    mutate(downloaded = download_data(links, city_name = city, file_name = file_name))
  
  return(data)
}
