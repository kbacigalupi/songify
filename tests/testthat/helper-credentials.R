library(spotifyr)
credentials <- tryCatch(expr = {
    list(token = spotifyr::get_spotify_access_token(), found = TRUE)
  },
  error = function(e) {
    list(token = NA_character_, found = FALSE)
  }
)
