source("R/Api.R")

#' @title Recommend a song
#'
#' @description
#' Given a song title or artist (or other items tbd..)
#' @export
rec_song <- function(genre, mode = NULL, energy = NULL, loudness = NULL, valence = NULL,
                     danceability = NULL, instrumentalness = NULL, min_duration = NULL, max_duration = NULL) {

  # Filter artists based on genre
  artists <- get_genre_artists(genre)

  # If artists are found for the specified genre
  if (length(artists) == 0) {
    return("No artists found for this genre, try again")
  }


  # Select a random artist
  artist <- sample_n(artists, 1)


  tracks <- get_artist_audio_features(artist$id)
  # Apply other filters based on user inputs
  if (!is.null(mode)) {
    tracks <- tracks |>
      filter(mode == mode)
  }
  if (!is.null(energy)) {
    tracks <- tracks |>
      filter(abs(energy - energy) <= 0.1)
  }
  if (!is.null(loudness)) {
    tracks <- tracks |>
      filter(abs(loudness - loudness) <= 1)
  }
  if (!is.null(valence)) {
    tracks <- tracks |>
      filter(abs(valence - valence) <= 0.1)
  }
  if (!is.null(danceability)) {
    tracks <- tracks |>
      filter(abs(danceability - danceability) <= 0.1)
  }
  if (!is.null(instrumentalness)) {
    tracks <- tracks |>
      filter(abs(instrumentalness - instrumentalness) <= 0.1)
  }
  if (!is.null(min_duration)) {
    tracks <- tracks |>
      filter(duration_ms >= min_duration * 1000)  # Convert duration to milliseconds
  }
  if (!is.null(max_duration)) {
    tracks <- tracks |>
      filter(duration_ms <= max_duration * 1000)
  }

  # If no tracks are found after filtering
  if (nrow(tracks) == 0) {
    return("No tracks found, try again")  # or return a message indicating no tracks found
  }

  # Select a random track
  track <- sample_n(tracks, 1)
  print(track)
  # Return the recommended track
  return(song(track$track_name, track$artist_name, track$duration_ms, track$danceability, track$energy, track$key_mode, track$tempo))
}

