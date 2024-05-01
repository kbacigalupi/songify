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
            "duration" = duration,
            "genre" = genre,
            "danceability" = danceability,
            "energy" = energy,
            "key" = key,
            "tempo" = tempo,
            #Notes that this is a subclass of playlist
            class = "song"
            #       subclass
  )
}

#' @title Song Validator
#'
#' @description Makes sure an object with song has the correct properties of a song
#' @param obj An object of the type song
validate_song <- function(obj) {
  if(!is.character(attr(obj, "author")) | !is.character(attr(obj, "key"))) {
    stop("The author and key of the song must be characters")
  }

  if(!is.double(attr(obj, "duration")) & !is.double(attr(obj, "tempo"))) {
    stop("The duration of the song and tempo must be a number (in seconds & in bpm)")
  }

  if((!is.double(attr(obj, "danceability")) & (0 <= attr(obj, "danceability")) & (attr(obj, "danceability") <=1)) |
  (!is.double(attr(obj, "energy")) & (0 <= attr(obj, "energy")) & (attr(obj, "energy") <=1))) {
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
#' @param key_mode A character describing whether the song is major, minor, and in what key (A - G)
#' @param tempo in BPM
song <- function(title, author, duration, genre, danceability, energy, key_mode, tempo) {
  duration = duration / 1000
  song <- new_song(title, author, duration, genre, danceability, energy, key_mode, tempo) |>
    validate_song()

  return(song)
}


#' @title Print Song
#'
#' @description Prints objects of song class in neat format
#' @param x An object of type song to print out
#' @param ... to adhere to generic print method
#' @exportS3Method
print.song <- function(x, ...) {

  if (!is.null(attr(x, "duration"))) {
    duration_min <- round(attr(x, "duration")/60, 0)
    duration_secs <- round(attr(x, "duration") %% 60, 0)
    if (duration_secs < 10) {
      duration_secs <- paste0("0", duration_secs)
    }
    duration <- paste0(duration_min, ":", duration_secs)
  }
  else {
    duration_min = " "
  }
  #ndots <- 50-nchar(x)
  song_string <- paste0(x, ", ", attr(x, "author"), ".................", duration)
  return(song_string)
}

#' @title Song Summary
#'
#' @description Presents information about song in table forms
#' @param object an object of type song to summarize in more detail
#' @param ... to adhere to generic summary method
#' @exportS3Method
summary.song <- function(object, ...) {
  summary_tbl <- data.frame(song = object,
                            "Genre" = attr(object, "genre"),
                            "Danceability" = attr(object, "danceability"),
                            "Energy" =  attr(object, "energy"),
                            "Key" = attr(object, "key"),
                            "Tempo" = attr(object, "tempo")
                            )
  return(summary_tbl)
}
