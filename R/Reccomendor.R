#' @title Recommend a song
#'
#' @description
#' Given a song title or artist (or other items tbd..)
#' @export]
rec_song <- function(title) {
  return(title)
}

rec_song <- function(genre, mode, energy, loudness, valence, danceability, instrumentalness, min_duration, max_duration) {
  # Filter dataframe based on genre and mode
  filterd_song <- song_bank[song_bank$Genre == genre & song_bank$Mode == mode,]

  # Filter dataframe based on energy, loudness, valence, danceability, instrumentalness, and duration
  filterd_song <- filterd_song[filterd_song$Energy >= energy &
                                 filterd_song$Loudness >= loudness &
                                 filterd_song$Valence >= valence &
                                 filterd_song$Danceability >= danceability &
                                 filterd_song$Instrumentalness <= instrumentalness &
                                 filterd_song$Duration >= min_duration &
                                 filterd_song$Duration <= max_duration,]

  # If multiple songs match the criteria, select one randomly
  if (nrow(filterd_song) > 0) {
    rec_song <- filterd_song[sample(nrow(filterd_song), 1),]
    return(rec_song)
  } else {
    return(NULL)
  }
}
