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

#HELP - NOT SURE IF I CAN JUST PUT THIS IN HERE - ONLY WE NEED IT
key_translator <- c("C", "C#/Dflat", "D", "D#/Eflat", "E", "F", "F#/Gflat","G", "G#/Aflat", "A", "A#/Bflat", "B")

#' @title Song Validator
#'
#' @description Makes sure an object with song has the correct properties of a song
#' @param obj An object of the type song
validate_song <- function(obj) {
  if(!is.character(obj) | !is.character(attr(obj, "author")) | is.character(attr(obj, "author"))) {
    stop("The title, author, genre, and key of the song must be characters")
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
song <- function(title, author, duration, genre, danceability, energy, key, mode, tempo) {
  if((key < 1) | key > 12) {
    stop("Key must be an integer between 1 and 12")
  }
  key = key_translator[key]

  if(mode == 0) {
    key <- paste(key, "Minor")
  }
  else if(mode == 1) {
    key <- paste(key, "Major")
  }
  else {key <- past(key, "Minor")}

  song <- new_song(title, author, duration, genre, danceability, energy, key, tempo) |>
    validate_song()

  return()
}
