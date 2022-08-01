## setup.R ##
library(R.utils)

# Required packages
packages <- c("tidyverse",
              "shiny",
              "shinydashboard",
              "shinydashboardPlus",
              "waiter",
              "plumber",
              "leaflet",
              "DT",
              "argparse")

# Find installed packages
is_packages_installed <-
  packages %in% rownames(installed.packages())

# Install packages if missing
if (any(is_packages_installed == FALSE)) {
  install.packages(packages[!is_packages_installed], repos = "http://cran.us.r-project.org")
}

# Load packages
invisible(lapply(packages, library, character.only = TRUE))

# Create symlinks for app
createLink(
  link = paste0(getwd(), "/app/data"),
  target = paste0(getwd(), "/data/processed")
)

# Create symlinks for api
createLink(
  link = paste0(getwd(), "/api/data"),
  target = paste0(getwd(), "/data/processed")
)