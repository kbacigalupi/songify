#' @title Playlist Generator
#' @description Returns a playlist for a user given a genre other characteristics
#' @importFrom purrr map_vec
#' @importFrom purrr modify_if
#' @param nsongs the number of songs in a
#' @param genre the genre
#' @return An object of the song class
#' @export
get_playlist <- function(genre, nsongs) {
  songs <- vector(song, nsongs)
  songs <- purrr::map_vec(.x = genre, .f = rec_song)
  songs <- purrr::modify_if(.x = songs, .p = duplicated, .f = rec_song)
  playlist(songs, genre)
}

