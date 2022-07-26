## start_app.R ##
library(shiny)

appDir <- "app"

if(!dir.exists(appDir)) {
  stop("Cannot start server. reason: directory 'app' not found in current path.")
}

shiny::runApp(appDir = appDir, host = "127.0.0.1", port = 9000)
