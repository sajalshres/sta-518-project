## start_app.R ##
library(argparse)
library(shiny)

parse_arguments <- function() {
  parser <- ArgumentParser(description = 'Process Airbnb dataset')
  
  parser$add_argument('--app-dir',
                      default = "app",
                      help = "Application directory")
  
  parser$add_argument('--host',
                      default = "127.0.0.1",
                      help = "Host name for the app server")
  
  parser$add_argument('--port',
                      type = "integer",
                      default = 8000,
                      help = "Port for the app server")
  
  args <- parser$parse_args()
  
  return(args)
}

# parse arguments
args <- parse_arguments()


# check if directory exists
if (!dir.exists(args$app_dir)) {
  stop(
    paste0(
      "Cannot start server. reason: directory '",
      args$app_dir,
      "' not found in current path."
    )
  )
}

# start the server
shiny::runApp(appDir = args$app_dir, host = args$host, port = args$port)
