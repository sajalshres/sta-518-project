

analyzeRoomTypeProportion <- function(listings) {
  listings %>%
    count(room_type, sort = TRUE, name = "count") %>%
    ggplot(aes(x = "", y = count, fill = reorder(room_type, -count))) +
    geom_bar(
      stat = "identity",
      width = 1,
      color = "white"
    ) +
    coord_polar("y", start = 0) +
    guides(fill = guide_legend(title = "Room Type")) +
    theme_void()
}


analyzeRoomTypeDistribution <- function(listings) {
  listings %>%
    mutate(price_log1p = log1p(price)) %>%
    ggplot(aes(x = price_log1p, fill = room_type)) +
    geom_density(alpha = 0.5)
}

analyzeTopHosts <- function(listings) {
  top_hosts <- listings %>%
    select(host_id, host_name) %>%
    mutate(name = paste0(host_name, "\n", "(", host_id, ")")) %>%
    count(name, sort = TRUE, name = "count") %>%
    slice(1:10)

  # Render bar chart
  top_hosts %>%
    # Feed the data to ggplot function
    ggplot(
      aes(
        x = reorder(as.factor(name), -count),
        y = count,
        fill = reorder(name, count)
      )
    ) +
    # Add bar line with no legend
    geom_bar(stat = "identity", width = 0.6, alpha = .8, show.legend = FALSE) +
    # Add label to each bar to show count
    geom_label(
      mapping = aes(label = count), size = 10, fill = "#FFFFFF", fontface = "bold"
    ) +
    # Fill the color with highest value with red to draw attention
    scale_fill_manual(values = rep(c("#2C3E50", "#E74C3C"), times = c(9, 1))) +
    # Apply custom theme
    theme(
      axis.text.x = element_text(size = 9, face = "bold"),
      axis.text.y = element_text(size = 8, face = "bold"),
      axis.title.x = element_text(size = 10),
      axis.title.y = element_text(size = 10),
    ) +
    labs(
      # Add x axis label
      x = "Hosts",
      # Add y axis label
      y = "Listings",
    ) +
    # Flip the co-ordinates
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

analyzeDistributionByPrice <- function(listings) {
  # Generate data for expensive neighbourhoods
  expensive_neighbourhoods <- listings %>%
    select(neighbourhood, price) %>%
    group_by(neighbourhood) %>%
    summarise(average_price = mean(price)) %>%
    arrange(desc(average_price)) %>%
    slice(1:10)

  # Compare neighbourhood and prices
  neighbourhood_price <- listings %>%
    select(neighbourhood, price) %>%
    filter(neighbourhood %in% expensive_neighbourhoods$neighbourhood) %>%
    mutate(price = log1p(as.numeric(price)))

  neighbourhood_price %>%
    ggplot(aes(x = neighbourhood, y = price, fill = neighbourhood)) +
    geom_boxplot(show.legend = FALSE) +
    # Apply custom theme
    theme(
      axis.text.x = element_text(size = 8, face = "bold"),
      axis.text.y = element_text(size = 8, face = "bold"),
      axis.title.x = element_text(size = 10),
      axis.title.y = element_text(size = 10),
    ) +
    labs(
      # Add x axis label
      x = "Neighbourhoods",
      # Add y axis label
      y = "Price",
    ) +
    # Flip the coordinates
    coord_flip()
}

analyzeMostCommonWords <- function(names) {
  # Create a vector containing only the text
  texts <- names

  # Create a corpus
  docs <- Corpus(VectorSource(texts))

  toSpace <-
    content_transformer(function(x, pattern) {
      gsub(pattern, " ", x)
    })
  docs <- tm_map(docs, toSpace, "/")
  docs <- tm_map(docs, toSpace, "@")
  docs <- tm_map(docs, toSpace, "\\|")

  # Convert the text to lower case
  docs <- tm_map(docs, content_transformer(tolower))
  # Remove numbers
  docs <- tm_map(docs, removeNumbers)
  # Remove english common stopwords
  docs <- tm_map(docs, removeWords, stopwords("english"))
  # Remove your own stop word
  # specify your stopwords as a character vector
  docs <- tm_map(docs, removeWords, c("blabla1", "blabla2"))
  # Remove punctuations
  docs <- tm_map(docs, removePunctuation)
  # Eliminate extra white spaces
  docs <- tm_map(docs, stripWhitespace)
  # Text stemming
  # docs <- tm_map(docs, stemDocument)

  dtm <- TermDocumentMatrix(docs)
  m <- as.matrix(dtm)
  v <- sort(rowSums(m), decreasing = TRUE)
  d <- data.frame(word = names(v), freq = v)

  set.seed(518)
  wordcloud(
    words = d$word,
    freq = d$freq,
    scale = c(5, .5),
    min.freq = 1,
    max.words = 200,
    random.order = FALSE,
    rot.per = 0.35,
    colors = brewer.pal(8, "Dark2")
  )
}
