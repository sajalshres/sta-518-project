## start_api.R ##
library(argparse)
library(plumber)

parse_arguments <- function() {
  parser <- ArgumentParser(description = 'Process Airbnb dataset')
  
  parser$add_argument('--app-dir',
                      default = "api",
                      help = "Application directory")
  
  args <- parser$parse_args()
  
  return(args)
}

# parse arguments
args <- parse_arguments()

# check if directory exists
if (!dir.exists(args$app_dir)) {
  stop(
    paste0(
      "Cannot start api server. reason: directory '",
      args$app_dir,
      "' not found in current path."
    )
  )
}

# Start the plumber api server
plumber::plumb(file = paste0(args$app_dir, "/app.R"))$run()
