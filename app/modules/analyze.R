

analyzeTopHosts <- function(listings) {
  top_hosts <- listings %>%
    count(host_id, sort = TRUE, name = "count") %>%
    slice(1:10)
  
  top_hosts %>%
    ggplot(aes(x = reorder(as.factor(host_id),-count), y = count)) +
    geom_bar(stat = "identity", width = 0.4) +
    xlab("Host ID") +
    ylab("Listings") +
    coord_flip()
}

anaylzeNeighbourhoodsByPrice <- function(listings, order = "asc", limit = 10) {
  neighbourhoodsDf <- listings %>%
    select(neighbourhood, price) %>%
    group_by(neighbourhood) %>%
    summarise(average_price = mean(price))
  
  if (order == "asc") {
    neighbourhoodsDf <- neighbourhoodsDf %>%
      arrange(average_price)
  } else {
    neighbourhoodsDf <- neighbourhoodsDf %>%
      arrange(desc(average_price))
  }
  
  neighbourhoodsDf %>%
    slice(1:limit) %>%
    ggplot(mapping = aes(x = neighbourhood, y = average_price)) +
    geom_bar(
      stat = "identity",
      mapping = aes(fill = neighbourhood, color = neighbourhood),
      alpha = .8,
      size = 1.5
    ) +
    coord_flip() +
    coord_polar()
}