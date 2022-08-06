## maps.R ##

mapsListingsPrice <- function(listings, opacity = 1) {
  # setup data
  map_data <- listings %>%
    select(id, name, host_name, latitude, longitude, neighbourhood, price) %>%
    rowwise() %>%
    # get more accurate result
    mutate(price_log1p = log1p(price), )

  pal <-
    colorNumeric("RdYlBu",
      domain = map_data$price_log1p,
      reverse = TRUE
    )

  # render map
  leaflet(data = map_data) %>%
    addProviderTiles(providers$CartoDB.Positron) %>%
    addCircleMarkers(
      ~longitude,
      ~latitude,
      color = ~ pal(price_log1p),
      weight = 2,
      radius = 3,
      fillOpacity = opacity,
      opacity = opacity,
      label = lapply(
        paste0(
          paste0("<P>Name: ", map_data$name, "</P>"),
          paste0("<P>Host: ", map_data$host_name, "</P>"),
          paste0("<P>Price: ", map_data$price, "</P>")
        ),
        htmltools::HTML
      )
    ) %>%
    addLegend(
      "bottomright",
      pal = pal,
      values = ~price_log1p,
      title = "Price",
      opacity = 1,
    ) %>%
    setView(mean(map_data$longitude), mean(map_data$latitude), zoom = 12)
}


updateMapsListingsPrice <-
  function(listings,
           neighbourhoods,
           roomType,
           priceRange = NULL,
           colorBy = "Price",
           numOfBedrooms = NULL,
           numOfBathrooms = "0",
           opacity = 1,
           size = 3) {
    if (is.null(numOfBathrooms)) {
      numOfBathrooms <- "0"
    }

    if (is.null(priceRange)) {
      priceRange <- c(0, max(listings$price))
    }

    numOfBathrooms <-
      as.numeric(gsub("([0-9]+).*$", "\\1", numOfBathrooms))


    # setup data
    map_data <- listings %>%
      select(
        id,
        name,
        host_name,
        latitude,
        longitude,
        neighbourhood,
        room_type,
        bedrooms,
        bathrooms,
        price
      ) %>%
      rowwise() %>%
      # get more accurate result
      mutate(price_log1p = log1p(price), )

    pal <- colorNumeric("RdYlBu", domain = map_data$price_log1p, reverse = TRUE)

    if (colorBy != "Price") {
      pal <- colorFactor("RdYlBu", domain = map_data$room_type, reverse = TRUE)
    }

    # Apply filters
    map_data <- map_data %>%
      filter(neighbourhood %in% neighbourhoods, room_type %in% roomType) %>%
      filter(bathrooms > numOfBathrooms) %>%
      filter(price %in% priceRange[1]:priceRange[2])

    # Conditional filters
    if (!is.null(numOfBedrooms)) {
      numOfBedrooms <-
        as.numeric(gsub("([0-9]+).*$", "\\1", numOfBedrooms))
      map_data <- map_data %>%
        filter(if (numOfBedrooms < 5) {
          bedrooms == numOfBedrooms
        } else {
          bedrooms > numOfBedrooms
        })
    }

    # render map
    map <- leafletProxy("mapPrice", data = map_data) %>%
      clearControls() %>%
      clearShapes() %>%
      clearMarkers() %>%
      addProviderTiles(providers$CartoDB.Positron)

    if (colorBy == "Price") {
      map %>%
        addCircleMarkers(
          ~longitude,
          ~latitude,
          color = ~ pal(price_log1p),
          weight = 1,
          radius = size,
          fillOpacity = opacity,
          opacity = 1,
          label = lapply(
            paste0(
              paste0("<P>Name: ", map_data$name, "</P>"),
              paste0("<P>Host: ", map_data$host_name, "</P>"),
              paste0("<P>Price: ", map_data$price, "</P>")
            ),
            htmltools::HTML
          )
        ) %>%
        addLegend(
          "bottomright",
          pal = pal,
          values = ~price_log1p,
          title = "Price",
          opacity = 1,
        ) %>%
        setView(mean(map_data$longitude), mean(map_data$latitude), zoom = 12)
    } else {
      map %>%
        addCircleMarkers(
          ~longitude,
          ~latitude,
          color = ~ pal(room_type),
          weight = 1,
          radius = size,
          fillOpacity = opacity,
          opacity = 1,
          label = lapply(
            paste0(
              paste0("<P>Name: ", map_data$name, "</P>"),
              paste0("<P>Host: ", map_data$host_name, "</P>"),
              paste0("<P>Price: ", map_data$price, "</P>")
            ),
            htmltools::HTML
          )
        ) %>%
        addLegend(
          "bottomright",
          pal = pal,
          values = ~room_type,
          title = "Room Type",
          opacity = 1,
        ) %>%
        setView(mean(map_data$longitude), mean(map_data$latitude), zoom = 12)
    }
  }
