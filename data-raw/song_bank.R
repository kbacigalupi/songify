## code to prepare `song_bank` dataset goes here
library(spotifyr)
library(dplyr)

## Client ID and Secret must be available in SPOTIFY_CLIENT_ID and SPOTIFY_CLIENT_SECRET
## environment variables.
access_token <- spotifyr::get_spotify_access_token()

taylor <- get_genre_artists("pop", limit = 1, authorization = access_token)

song_bank <- get_artist_audio_features(taylor$id) |>
  select(c("artist_name", "track_name", "album_type", "danceability", "energy", "key", "loudness", "mode", "speechiness", "acousticness", "instrumentalness", "liveness", "valence", "tempo", "time_signature", "duration_ms", "explicit"))


usethis::use_data(song_bank, overwrite = TRUE)
