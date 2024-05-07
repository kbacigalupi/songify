# Tests that the function returns a character string
test_that("rec_playlist returns an object of type playlist", {
  skip_if(Sys.getenv("SPOTIFY_CLIENT_ID") == "" || Sys.getenv("SPOTIFY_CLIENT_SECRET") == "", "Spotify API credentials not available")
  result <- rec_playlist(genre = "rock", nsongs = 2, mode = 1, energy = 0.8, valence = 0.7)
  expect_s3_class(result, "playlist")
})

# Tests that the playlist object is of the correct genre
test_that("rec_playlist returns playlist with correct genre", {
  skip_if(Sys.getenv("SPOTIFY_CLIENT_ID") == "" || Sys.getenv("SPOTIFY_CLIENT_SECRET") == "", "Spotify API credentials not available")
  result <- rec_playlist(genre = "funk", nsongs = 5)
  playlist_genre <- attr(result, "genre")
  expect_equal(playlist_genre, "funk")
})

# Tests if the user inputs an invalid genre the user will get a message
test_that("rec_playlist handles broken genres", {
  skip_if(Sys.getenv("SPOTIFY_CLIENT_ID") == "" || Sys.getenv("SPOTIFY_CLIENT_SECRET") == "", "Spotify API credentials not available")
  result <- rec_playlist(genre = "invalid_genre", nsongs = 3)
  expect_equal(result, "No artists found for this genre, try again")
})
