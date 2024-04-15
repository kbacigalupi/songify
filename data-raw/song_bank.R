## code to prepare `song_bank` dataset goes here

usethis::use_data(song_bank, overwrite = TRUE)

library(spotifyr)
library(parallel)
library(dplyr)
library(purrr)

secret <- '0bc3f31a7f674b7f969d69fb466d8822'
Sys.setenv(SPOTIFY_CLIENT_ID = '3f7d64c2c3a5444da33c10e8b3f42e55')
Sys.setenv(SPOTIFY_CLIENT_SECRET = '0bc3f31a7f674b7f969d69fb466d8822')

genres <- c("pop", "pop rap", "dance pop", "house", "teen pop", "electro house", "edm", "lounge", "classical", "soul", "r&b", "jazz")

artists <- function(genre) {
  Sys.sleep(0.05)
  get_genre_artists(genre, limit = 50)
}

songdata <- function(artist) {
  Sys.sleep(0.5)
  get_artist_audio_features(artist)
}

artist_bank <- mclapply(genres, artists)

#obviously bad code oops
get_names <- function(data) {
  data$name
}

artists_vector <- unique(unlist(lapply(artist_bank, get_names)))

song_bank <- mclapply(artists_vector, songdata)
  list_rbind() |>
  select("artist_name", "album_type", "danceability", "energy", "key", "loudness", "mode", "speechiness", "acousticness", "instrumentalness", "liveness", "valence", "tempo", "time_signature", "artists", "duration_ms", "explicit")


