## app.R ##
library(plumber)

#* @apiTitle Airbnb Analysis API
#* @apiDescription A rest api service for Airbnb data


root_api <- pr()
utils_api <- pr("routes/utils.R")
data_api <- pr("routes/data.R")

root_api %>%
  pr_set_docs("swagger") %>%
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
  pr_mount("/utils", utils_api) %>%
  pr_mount("/data", data_api) %>%
  pr_run(host = "127.0.0.1", port = 8000)
