source("R/Api.R")
#' @title Recommend a song
#' @description
#' Given a genre of song and optionally other
#' @importFrom spotifyr get_genre_artists
#' @importFrom spotifyr get_artist_audio_features
#' @importFrom dplyr sample_n
#' @importFrom dplyr filter
#' @param genre the genre
#' @param mode the mode, 0 for minor 1 for major
#' @param energy the energy of the song on a scale from 0.0-1.0
#' @param loudness the loudness of the song in decibels, values typically range from -60-0
#' @param valence describes the musical positiveness of a song on a scale from 0.0-1.0. Higher valence songs are more happy/euphoric, lower valence songs are more angry/depressed.
#' @param danceability describes how suitable the song is for dancing on a scale from 0.0-1.0.
#' @param instrumentalness predicts if a song has no vocals on a scale from 0.0-1.0. The higher the instrumentalness the greater the chance the song contains no vocal content.
#' @param min_duration the minimum duration of the song in seconds
#' @param max_duration the maximum duration of the song in seconds
#' @return an object of the song class
#' @export
rec_song <- function(genre, mode = NULL, energy = NULL, loudness = NULL, valence = NULL,
                     danceability = NULL, instrumentalness = NULL, min_duration = NULL, max_duration = NULL, print = TRUE) {

  # Filter artists based on genre
  artists <- spotifyr::get_genre_artists(genre)

  # If artists are found for the specified genre
  if (length(artists) == 0) {
    return("No artists found for this genre, try again")
  }


  # Select a random artist
  artist <- dplyr::sample_n(artists, 1)


  tracks <- spotifyr::get_artist_audio_features(artist$id)
  # Apply other filters based on user inputs
  if (!is.null(mode)) {
    tracks <- tracks |>
      dplyr::filter(mode == mode)
  }
  if (!is.null(energy)) {
    tracks <- tracks |>
      dplyr::filter(abs(energy - energy) <= 0.1)
  }
  if (!is.null(loudness)) {
    tracks <- tracks |>
      dplyr::filter(abs(loudness - loudness) <= 1)
  }
  if (!is.null(valence)) {
    tracks <- tracks |>
      dplyr::filter(abs(valence - valence) <= 0.1)
  }
  if (!is.null(danceability)) {
    tracks <- tracks |>
      dplyr::filter(abs(danceability - danceability) <= 0.1)
  }
  if (!is.null(instrumentalness)) {
    tracks <- tracks |>
      dplyr::filter(abs(instrumentalness - instrumentalness) <= 0.1)
  }
  if (!is.null(min_duration)) {
    tracks <- tracks |>
      dplyr::filter(duration_ms >= min_duration * 1000)  # Convert duration to milliseconds
  }
  if (!is.null(max_duration)) {
    tracks <- tracks |>
      dplyr::filter(duration_ms <= max_duration * 1000)
  }

  # If no tracks are found after filtering
  if (nrow(tracks) == 0) {
    return("No tracks found, try again")  # or return a message indicating no tracks found
  }

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

