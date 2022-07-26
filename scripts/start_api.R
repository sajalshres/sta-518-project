## start_api.R ##
library(plumber)

app_dir <- "api"

if(!dir.exists(app_dir)) {
  stop("Cannot start api server. reason: directory 'api' not found in current path.")
}

# Start the plumber api server
plumber::plumb(file = paste0(app_dir, "/app.R"))$run()
