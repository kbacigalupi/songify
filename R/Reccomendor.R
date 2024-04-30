#' @title Recommend a song
#' @description
#' Given a genre of song and optionally other
#'
#' @importFrom spotifyr get_genre_artists
#' @importFrom spotifyr get_artist_audio_features
#' @importFrom spotifyr get_spotify_access_token
#' @importFrom dplyr sample_n
#' @importFrom dplyr filter
#'
#' @param genre the genre
#' @param mode the mode, 0 for minor 1 for major
#' @param energy the energy of the song on a scale from 0.0-1.0
#' @param loudness the loudness of the song in decibels, values typically range from -60-0
#' @param valence describes the musical positiveness of a song on a scale from 0.0-1.0. Higher valence songs are more happy/euphoric, lower valence songs are more angry/depressed.
#' @param danceability describes how suitable the song is for dancing on a scale from 0.0-1.0.
#' @param instrumentalness predicts if a song has no vocals on a scale from 0.0-1.0. The higher the instrumentalness the greater the chance the song contains no vocal content.
#' @param min_duration the minimum duration of the song in seconds
#' @param max_duration the maximum duration of the song in seconds
#'
#' @return an object of the song class
#'
#' @export
rec_song <- function(genre, mode = NULL, energy = NULL, loudness = NULL, valence = NULL,
                     danceability = NULL, instrumentalness = NULL, print = TRUE) {

  # Filter artists based on genre

  tryCatch(expr = {
    access_token <- spotifyr::get_spotify_access_token()
  },
  error = function(e){
    message <- paste(
      "No valid spotify API credentials found. Use the R code below to store your spotify API credentials as environment variables:",
      "Sys.setenv(SPOTIFY_CLIENT_ID = 'xxxxxxxxxxxxxxxxxxxxx')",
      "Sys.setenv(SPOTIFY_CLIENT_SECRET = 'xxxxxxxxxxxxxxxxxxxxx')",
      "",
      "If you don't have a client ID and secret, see https://developer.spotify.com/documentation/web-api for instructions on how to obtain them.",
      sep = "\n"
      )
    stop(message, call. = FALSE)
  })

  artists <- spotifyr::get_genre_artists(genre, authorization = access_token)

  # If artists are found for the specified genre
  if (length(artists) == 0) {
    return("No artists found for this genre, try again")
  }


  # Select a random artist
  artist <- dplyr::sample_n(artists, 1)


  tracks <- spotifyr::get_artist_audio_features(artist$id)
  print(nrow(tracks))
  # Apply other filters based on user inputs
  if (!is.null(mode)) {
    tracks <- dplyr::filter(tracks, tracks$mode == mode)
  }
  if (!is.null(energy)) {
    tracks <- dplyr::filter(tracks, abs(tracks$energy - energy) <= 0.1)
  }
  if (!is.null(loudness)) {
    tracks <- dplyr::filter(tracks, abs(tracks$loudness - loudness) <= 0.1)
  }
  if (!is.null(valence)) {
    tracks <- dplyr::filter(tracks, abs(tracks$valence - valence) <= 0.1)
  }
  if (!is.null(danceability)) {
    tracks <- dplyr::filter(tracks, abs(tracks$danceability - danceability) <= 0.1)
  }
  if (!is.null(instrumentalness)) {
    tracks <- dplyr::filter(tracks, (abs(tracks$instrumentalness - instrumentalness) <= 0.1))
  }


  # If no tracks are found after filtering
  if (nrow(tracks) == 0) {
    return("No tracks found, try again")  # or return a message indicating no tracks found
  }

  #print(nrow(tracks))

  # Select a random track
  track <- dplyr::sample_n(tracks, 1)
  #print(track)

  # Return the recommended track
  song <- song(track$track_name, track$artist_name, track$duration_ms, genre, track$danceability, track$energy, track$key_mode, track$tempo)
  if (print == TRUE) {
    print(paste0("", print(song)))
  }
  return(song)
}

