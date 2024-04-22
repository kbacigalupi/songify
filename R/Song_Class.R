#' @title Song Constructor
#'
#' @description Constructor for song class
#' @param title Title of the song
#' @param author Author of the song
#' @param duration The length of song in seconds
#' @param genre One Genre of the song (spotify can classify songs in multiple
#'   genres - in this case whatever the user has asked for is the genre)
#' @param danceability On a scale of 0 to 1
#' @param energy Measure from 0 to 1 on "perceptual measure of intensity and
#'   activity" where 1 is more active
#' @param key Major or minor, C - B
#' @param tempo in BPM
new_song <- function(title, author, duration, genre, danceability, energy, key, tempo) {

  structure(title,
            "author" = author,
            "genre" = weights,
            "danceability" = danceability,
            "energy" = energy,
            #Notes that this is a subclass of playlist
            class = c("song", "playlist")
            #       subclass, superclass
  )
}

#' @title Song Validator
#'
#' @description Makes sure an object with song has the correct properties of a song
#' @param obj An object of the type song
validate_song <- function(obj) {
  if(!is.character(attr(obj, "author")) | is.character(attr(obj, "key"))) {
    stop("The author and key of the song must be characters")
  }

  if(!is.double(attr(obj, "duration")) & !is.double(attr(obj, "tempo"))) {
    stop("The duration of the song and tempo must be a number (in seconds & in bpm)")
  }

  if((!is.double(attr(obj, "danceability")) & (0 <= attr(obj, "danceability")) & (attr(obj, "danceability") <=1)) |
  (!is.double(attr(obj, "energy")) & (0 <= attr(obj, "energy")) & attr(obj, "energy" <=1))) {
      stop("Danceability and energy must be numbers between 1 and 0")
  }

  return(obj)
}


#' @title Song Helper
#'
#' @description The helper function called in song generator that makes a song
#' @param title Title of the song
#' @param author Author of the song
#' @param duration The length of song in milliseconds, converted to seconds
#' @param genre One Genre of the song (spotify can classify songs in multiple
#'   genres - in this case whatever the user has asked for is the genre)
#' @param danceability On a scale of 0 to 1
#' @param energy Measure from 0 to 1 on "perceptual measure of intensity and
#'   activity" where 1 is more active
#' @param key Number 1 - 12 that is translated into Words
#' @param mode Major (1) or Minor (0) combined with key to produce the key of song in character value
#' @param tempo in BPM
song <- function(title, author, duration, genre, danceability, energy, key_mode, tempo) {
  song <- new_song(title, author, duration, genre, danceability, energy, key, tempo) |>
    validate_song()

  return()
}

#' @title Print Song
#'
#' @description Prints objects of song class in neat format
#' @param song An object of type song to print out
print.song <- function(song) {
  song_string <- c(title, ", ", author, ".................", duration)
  return(song_string)
}

#' @title Song Summary
#'
#' @description R
#' @param song an object of type song to summarize in more detail
summary.Song <- function(song) {

}
