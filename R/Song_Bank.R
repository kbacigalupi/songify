#' @title Song bank example of Taylor Swift songs on Spotify
#'
#' @description pulled with [spotifyr::get_artist_audio_features()] using artist
#'   id of Taylor Swift.
#'
#' @format
#' \describe{
#'   \item{artist_name}{Artist who released the song} \item{danceability}{How
#'   suitable track is for dancing from 0 to 1}
#'   \item{energy}{Measure from 0 to 1 on "perceptual measure of intensity and
#'   activity" where 1 is more active}
#'   \item{key}{Key of track in Pitch Class notation (0 = C, 1 = C#/Dflat) -1 if
#'   not detected} \item{loudness}{overall loudness of a track in decibels}
#'   \item{mode}{Major or minor} \item{instrumentalness}{Measure of lack of
#'   words (0 is words, 1 is instrumental, >0.5 instrumental} \item{valence}{The
#'   musical "positiveness" - high would be happy/cheerful, low is
#'   sad/depressed/angry} \item{tempo}{Tempo in bpm}\item{duration_ms}{Length of track in milliseconds}
#' }
#'
#' @source Spotify API, documentation:
#'   https://developer.spotify.com/documentation/web-api/reference/get-audio-features
"song_bank"
