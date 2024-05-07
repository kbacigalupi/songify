#' @title Recommend a song
#'
#' @description Given a genre of song and optionally other
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
#' @param valence describes the musical positiveness of a song on a scale from
#'   0.0-1.0. Higher valence songs are more happy/euphoric, lower valence songs
#'   are more angry/depressed.
#' @param danceability describes how suitable the song is for dancing on a scale
#'   from 0.0-1.0.
#' @param instrumentalness predicts if a song has no vocals on a scale from
#'   0.0-1.0. The higher the instrumentalness the greater the chance the song
#'   contains no vocal content.
#' @param p Whether the song will be printed (mostly internal use when building
#'   playlists)
#' @return an object of the song class with the following elements
#' * song
#' * author
#' * duration
#' * genre
#' * danceability
#' * energy
#  * key_mode (A-B, Major/Minor)
#' * tempo
#' @examples
#' \dontrun{
#' rec_song("pop", mode = 1, energy = 0.7, valence = 0.5, danceability = 0.8,
#' instrumentalness = 0.7)
#' }
#' @export
rec_song <- function(genre, mode = NULL, energy = NULL, valence = NULL,
                     danceability = NULL, instrumentalness = NULL, p = TRUE) {

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

  # Additional check to handle empty artist data frame
  if (nrow(artists) == 0) {
    return("No artists found for this genre, try again")
  }

  dif <-  0.08

  # Select a random artist
  artist <- dplyr::sample_n(artists, 1)
  # Get audio features for the selected artist, if the artist token is fault picks new artists

  for (i in 1:5) {
    tryCatch(expr = {
      tracks <- spotifyr::get_artist_audio_features(artist$id)
      break()
    }, error = function(e) {
      message("Thanks for your patience - We are pulling only the best songs for you")
    })
    artists <- artists |> filter(artists$id != artist$id)
    artist <- dplyr::sample_n(artists, 1)
  }


  # Create a loop to keep trying with different artists until a track is found
  while (TRUE) {
    dif <- dif + 0.02

    if (dif > 0.22){
      print("Try different track settings - there were not enough tracks with your requirements ")
      break
    }

    # Combine all filters into one filter expression
    filters <- TRUE

    if (!is.null(mode)) {
      filters <- filters & (tracks$mode == mode)
    }
    if (!is.null(energy)) {
      filters <- filters & abs(tracks$energy - energy) <= dif
    }

    if (!is.null(valence)) {
      filters <- filters & abs(tracks$valence - valence) <= dif
    }
    if (!is.null(danceability)) {
      filters <- filters & abs(tracks$danceability - danceability) <= dif
    }
    if (!is.null(instrumentalness)) {
      filters <- filters & abs(tracks$instrumentalness - instrumentalness) <= dif
    }

    # Apply the filters
    filtered_tracks <- tracks[filters, ]

    # If tracks are found after filtering, break the loop
    if (nrow(filtered_tracks) > 0) {
      # Select a random track from the filtered tracks
      track <- dplyr::sample_n(filtered_tracks, 1)

      # Create the song object and print it
      song <- song(track$track_name, track$artist_name, track$duration_ms, genre, track$danceability, track$energy, track$key_mode, track$tempo)

      if (p != FALSE) {
        print(paste0("", print(song)))
      }

      return(song)
    }

    tryCatch(expr = {
      tracks <- rbind(tracks, spotifyr::get_artist_audio_features(dplyr::sample_n(artists, 1)$id))
    }, error = function(e) {
      artists <- artists |> filter(artists$id != artist$id)
      message("Thanks for your patience - We are pulling only the best songs for you")
    })
  }
}
