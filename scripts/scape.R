library("rvest")

page_data <- read_html("http://insideairbnb.com/get-the-data/")

locations <- page_data %>%
  html_elements("h3") %>%
  html_text()

print(locations)
