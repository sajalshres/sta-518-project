## analyze.R ##

#* Get the top hosts data for requested city
#* @get /top-hosts
#* @param city Name of the city
#* @tag analyze
get_top_host <- function(res, city = "chicago") {
  # Read listing object by city
  listings <-
    readRDS(paste0("data/", city, "_listings.Rds"))

  top_hosts <- listings %>%
    select(host_id) %>%
    count(host_id, sort = TRUE, name = "count") %>%
    slice(1:10)

  return(top_hosts)
}

#* Get the top expensive neighbourhoods data for requested city
#* @get /top-expensive-neighbourhoods
#* @param city Name of the city
#* @tag analyze
get_top_expensive_neighbourhoods <- function(res, city = "chicago") {
  # Read listing object by city
  listings <-
    readRDS(paste0("data/", city, "_listings.Rds"))

  expensive_neighbourhoods <- listings %>%
    select(neighbourhood, price) %>%
    group_by(neighbourhood) %>%
    summarise(average_price = mean(price)) %>%
    arrange(desc(average_price)) %>%
    slice(1:10)

  return(expensive_neighbourhoods)
}
