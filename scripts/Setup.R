# Required packages
packages <- c("tidyverse",
              "shiny",
              "shinydashboard",
              "plumber",
              "leaflet",
              "DT")

# Find installed packages
is_packages_installed <-
  packages %in% rownames(installed.packages())

# Install packages if missing
if (any(is_packages_installed == FALSE)) {
  install.packages(packages[!is_packages_installed], repos = "http://cran.us.r-project.org")
}

# Load packages
invisible(lapply(packages, library, character.only = TRUE))
