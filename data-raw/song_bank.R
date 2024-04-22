## code to prepare `song_bank` dataset goes here


library(spotifyr)
library(dplyr)

secret <- '0bc3f31a7f674b7f969d69fb466d8822'
Sys.setenv(SPOTIFY_CLIENT_ID = '0a9a4d1514b3400abb2f141a32dd0bac')
Sys.setenv(SPOTIFY_CLIENT_SECRET = '29862f8cb29c41b18d9d234947009a19')


taylor <- get_genre_artists("pop", limit = 1)

song_bank <- get_artist_audio_features(taylor$id) |>
  select(c("artist_name", "track_name", "album_type", "danceability", "energy", "key", "loudness", "mode", "speechiness", "acousticness", "instrumentalness", "liveness", "valence", "tempo", "time_signature", "duration_ms", "explicit"))


usethis::use_data(song_bank, overwrite = TRUE)
