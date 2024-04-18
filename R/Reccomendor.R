#' @title Recommend a song
#'
#' @description
#' Given a song title or artist (or other items tbd..)
#' @export]
rec_song <- function(title) {
  return(title)
}


rec_song <- function(genre, mode = NULL, energy = NULL, loudness = NULL, valence = NULL, danceability = NULL, instrumentalness = NULL, min_duration = NULL, max_duration = NULL) {
  artists <- get_genre_artists(genre)
  artist <- sample(artists, 1)
  albums <- get_artist_albums(artist)
  album <- sample(albums, 1)
  tracks <- get_album_tracks(album)
  return(tracks)
}

