## data.R ##
library(plumber)



#* Echo back the input
#* @get /data
#* @param city Name of the city
#* @tag data
data <- function(city=""){
  list(msg = paste0("You requested data for: '", city, "'"))
}