#' @title Playlist Generator
#' @description Returns a playlist for a user given a genre other characteristics
#' @importFrom purrr map_vec
#' @importFrom purrr modify_if
#' @param nsongs the number of songs in a
#' @param genre the genre
#' @return An object of the song class
#' @export
rec_playlist <- function(genre, nsongs, ...) {
  if (nsongs > 15 | nsongs < 1) {
    stop("Please enter a number between 1 and 15")
  }
  song_criteria <- list(...)
  empty_songs <- rep(c(genre), each = nsongs)
  songs <- purrr::map(.x = empty_songs, ... = ..., .f = rec_song)
  if(anyDuplicated(songs) != 0) {
    songs <- flip_repeats(songs, genre, ...)
    }
  playlist <- playlist(songs, genre)
  print(playlist)
  return(playlist)
}

flip_repeats <- function(songs, genre, ...) {
  while(anyDuplicated(songs) != 0) {
    songs[[anyDuplicated(songs)]] <- rec_song(genre = genre, ...)
  }
  return(songs)
}
