## api.R ##
library(plumber)

#* Echo back the input
#* @get /echo
#* @param msg The message to echo
echo <- function(msg=""){
  list(msg = paste0("The message is: '", msg, "'"))
}