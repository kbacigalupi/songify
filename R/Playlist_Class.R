#' @title Playlist Constructor
#'
#' @description Constructor for Playlist class
#' @param songs list of song objects
#' @param genre a character representing what genre the songs in the playlist all fall under
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
#' @description An S3 method to print playlists
#' @param x A playlist object to be printed
#' @param ... To adhere to generic print method
#' @exportS3Method
#'
print.playlist <- function(x, ...) {
  print(paste("There are", attr(x, "nsongs"), "song(s) in your playlist:"))
  for(i in seq_along(x)) {
    print(paste0("", print.song(x[[i]])))
  }
}

#' @title Summarizing Songs in the playlist
#'
#' @description Summarizes each song & it's characteristics
#' @param object An object of the type playlist to be summarized
#' @param ... to adhere to generic summary method
#' @importFrom purrr map
#' @exportS3Method
summary.playlist <- function(object, ...) {
  #print(class(object))
  #print(attr(object, "nsongs"))
  nsongs <- attr(object, "nsongs")
  sum_tbl <- data.frame(matrix(NA, nrow = nsongs, ncol = 7))
  colnames(sum_tbl) = c("Title", "Genre", "Author", "Danceability", "Energy", "Key", "Tempo")
  for (i in 1:nsongs) {
    sum_tbl[i, 1] = object[[i]]
    sum_tbl[i, 2] = attr(object[[i]], 'genre')
    sum_tbl[i, 3] = attr(object[[i]], 'author')
    sum_tbl[i, 4] = attr(object[[i]], 'danceability')
    sum_tbl[i, 5] = attr(object[[i]], 'energy')
    sum_tbl[i, 6] = attr(object[[i]], 'key')
    sum_tbl[i, 7] = attr(object[[i]], 'tempo')
  }
  return(sum_tbl)
}

##
#sum_tbl <- purrr::map(x, summary)
#print(sum_tbl)
#sum_tbl <- sum_tbl |>
  #purrr::reduce(dplyr::full_join)
