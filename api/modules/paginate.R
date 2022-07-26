## paginate.R ##
library(jsonlite)
library(plumber)
library(tidyverse)


paginate_data <- function(res,
                          df,
                          page_size = 1000,
                          page = 1) {
  # calculate total pages
  total_pages <- ceiling(nrow(df) / page_size)
  # set start slice
  start <- (page - 1) * page_size + 1
  # set end slice
  end <- page * page_size
  
  # if page is 1, then data must be sliced from 1
  if (page == 1) {
    start <- page
  }
  
  # if page is last, then slice all remaining rows
  if (page == total_pages) {
    end <- nrow(df)
  }
  
  # handle error
  if (page > total_pages) {
    # Set status as bad request
    res$status <- 400
    # Handle error
    return(list(error = jsonlite::unbox(
      paste0(
        "Reguested page number is greater than available page ",
        total_pages
      )
    )))
  }
  
  # paginate the response based of page requested
  paginated_result <- df %>%
    slice(start:end)
  
  # return response
  return(
    list(
      page = page,
      total_pages = total_pages,
      total_count = nrow(df),
      results = paginated_result
    )
  )
}