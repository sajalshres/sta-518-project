## api.R ##
library(plumber)

#* Echo back the input
#* @get /echo
#* @param msg The message to echo
#* @tag utils
echo <- function(msg=""){
  list(msg = paste0("The message is: '", msg, "'"))
}