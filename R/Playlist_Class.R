#' @title Playlist Constructor
#'
#' @description Constructor for Playlist class
#' @param songs list of song objects
new_playlist <- function(songs, genre) {

  structure(songs,
            "genre" = genre,
            "nsongs" = length(songs),
            class = "playlist"
  )
}

#' @title Playlist Validator
#'
#' @description Makes sure an object with playlist has the correct attributes of playlist
#' @param obj An object of the type playlist
validate_playlist <- function(obj) {

  if(!is.character(attr(obj, "genre"))) {
    stop("Genre must be a character")
  }

  for (i in 1:length(obj)) {
    validate_song(obj[[i]])
  }

  return(obj)
}


#' @title Playlist Helper
#'
#' @description The helper function called in playlist generator to make playlist
#' @param songs A list with items of the type Song
#' @param genre Genre of the playlist
#'
playlist <- function(songs, genre) {
  playlist <- new_playlist(songs, genre) |>
    validate_playlist()

  return(playlist)
}


#' @title Print Playlist
#'
#' @description The helper function called in playlist generator to make playlist
#' @param songs A song
#' @param genre Genre of the playlist
#' @exportS3Method
#'
print.playlist <- function(x) {
  print(paste("There are", attr(x, "nsongs"), "songs in your playlist:"))
  for(i in seq_along(x)) {
    print(paste0("", print.song(x[[i]])))
  }
}

#' @title Summarizing Songs in the playlist
#'
#' @description Makes sure an object with playlist has the correct attributes of playlist
#' @param obj An object of the type playlist
summary.playlist <- function(x) {

}
