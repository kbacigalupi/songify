## code to prepare `song_bank` dataset goes here


library(spotifyr)
library(dplyr)

source("API_raw.R")
taylor <- get_genre_artists("pop", limit = 1)

song_bank <- get_artist_audio_features(taylor$id) |>
  select(c("artist_name", "track_name", "album_type", "danceability", "energy", "key", "loudness", "mode", "speechiness", "acousticness", "instrumentalness", "liveness", "valence", "tempo", "time_signature", "duration_ms", "explicit"))


usethis::use_data(song_bank, overwrite = TRUE)
