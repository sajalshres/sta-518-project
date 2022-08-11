## global.R ##
## Objects defined in global.R are similar to those defined in app.R outside of the server function
## definition, with one important difference: they are loaded into the global environment of the R
## session; all R code in a Shiny app is run in the global environment or a child of it.
## https://shiny.rstudio.com/articles/scoping.html

# https://www.tidyverse.org/
library(tidyverse)
# https://rstudio.github.io/DT/
library(DT)
# https://shiny.rstudio.com/articles/basics.html
library(shiny)
# https://rstudio.github.io/shinydashboard/get_started.html
library(shinydashboard)
# https://github.com/dreamRs/shinyWidgets
library(shinyWidgets)
# https://github.com/RinteRface/shinydashboardPlus
library(shinydashboardPlus)
# https://github.com/JohnCoene/waiter
library(waiter)
# https://rstudio.github.io/leaflet/
library(leaflet)
# https://www.rdocumentation.org/packages/tm/versions/0.7-8
library(tm)
# https://www.rdocumentation.org/packages/SnowballC/versions/0.7.0
library(SnowballC)
# https://r-graph-gallery.com/wordcloud.html
library(wordcloud)
# https://cran.r-project.org/web/packages/RColorBrewer/index.html
library(RColorBrewer)

utils::globalVariables(c("select"))
