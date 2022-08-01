## maps.R ##

mapsListingsPrice <- function(listings) {
  # setup data
  map_data <- listings %>%
    select(id, name, host_name, latitude, longitude, neighbourhood, price) %>%
    rowwise() %>%
    # get more accurate result
    mutate(
      price_log1p = log1p(price),
    )
  
  pal <-
    colorNumeric("RdYlBu", domain = map_data$price_log1p, reverse = TRUE)
  
  # render map
  leaflet(data = map_data) %>%
    addProviderTiles(providers$CartoDB.Positron) %>%
    addCircleMarkers(
      ~ longitude,
      ~ latitude,
      color = ~ pal(price_log1p),
      weight = 1,
      radius = 2,
      fillOpacity = 1,
      opacity = 1,
      label = lapply(
        paste0(
          paste0("<P>Name: ",  map_data$name, "</P>"),
          paste0("<P>Host: ",  map_data$host_name, "</P>"),
          paste0("<P>Price: ",  map_data$price, "</P>")
        ), 
        htmltools::HTML
      )
    ) %>%
    addLegend(
      "bottomright",
      pal = pal,
      values = ~ price_log1p,
      title = "Price",
      opacity = 1,
    ) %>%
    setView(mean(map_data$longitude), mean(map_data$latitude), zoom = 12)
}