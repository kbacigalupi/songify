#' @title Playlist Generator
#' @description Returns a playlist for a user given a genre other characteristics
#' @importFrom purrr map
#' @param nsongs the number of songs in the playlist, maximum of 15
#' @param genre the genre a user wants all songs in their playlists to fit under
#' @param ... Other specifications for the playlist, all specifications for rec_song welcome
#' @return An object of the song class
#' @examples
#' \dontrun{
#' rec_playlist("funk", 3)
#' rec_playlist("pop", 4, energy = 0.5, mode = 1, danceability = .7)
#' }
#' @export
rec_playlist <- function(genre, nsongs, ...) {
  if (nsongs > 15 | nsongs < 1) {
    stop("Please enter a number between 1 and 15")
  }
  song_criteria <- list(...)
  empty_songs <- rep(c(genre), each = nsongs)
  songs <- purrr::map(.x = empty_songs, ... = ..., p = FALSE, .f = rec_song)
  if(anyDuplicated(songs) != 0) {
    songs <- flip_repeats(songs, genre, ...)
    }
  playlist <- playlist(songs, genre)
  return(playlist)
}


flip_repeats <- function(songs, genre, ...) {
  while(anyDuplicated(songs) != 0) {
    songs[[anyDuplicated(songs)]] <- rec_song(genre = genre, ..., p = FALSE)
  }
  return(songs)
}
