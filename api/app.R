## app.R ##
library(plumber)

#* @apiTitle Airbnb Analysis API
#* @apiDescription A rest api service for Airbnb data


# Root api object to mount all the routes
root_api <- pr()
# Utils api object that provides utility routes
utils_api <- pr("routes/utils.R")
# Data api object that provides data routes
data_api <- pr("routes/data.R")

root_api %>%
  # Set documentation function as swagger. Another alternative is redoc
  pr_set_docs("swagger") %>%
  # Set api specifications and info such as title, description
  pr_set_api_spec(function(spec) {
    spec$info <- list(
      title = "Airbnb Analysis API",
      description = "An api service for Airbnb analysis data",
      contact = list(
        name = "Sajal Shrestha",
        url = "https://sajalshres.github.io",
        email = "shressaj@mail.gvsu.edu"
      ),
      license = list(name = "Apache 2.0", url = "https://www.apache.org/licenses/LICENSE-2.0.html"),
      version = "0.0.1"
    )
    spec$tags <-
      list(
        list(name = "utils", description = "Provides utilities services"),
        list(name = "data", description = "Provides access to raw data for Airbnb data")
      )
    spec
  }) %>%
  # set default serializer to return unboxed JSON
  pr_set_serializer(serializer_unboxed_json()) %>%
  # mount utils routes
  pr_mount("/utils", utils_api) %>%
  # mount data routes
  pr_mount("/data", data_api) %>%
  # run the server
  pr_run(host = "0.0.0.0", port = 8000)
