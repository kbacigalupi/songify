# credentials object is created in helper-credentials.R

# Tests that the function returns an object of the song class
test_that("rec_song returns an object of the class song for valid input", {
  skip_if(Sys.getenv("SPOTIFY_CLIENT_ID") == "" || Sys.getenv("SPOTIFY_CLIENT_SECRET") == "", "Spotify API credentials not available")
  result <- rec_song(genre = "rock", mode = 1, energy = 0.8, valence = 0.7)
  expect_s3_class(result, "song")
})

# Tests if the user inputs an invalid genre
test_that("rec_song handles invalid genre", {
  skip_if(Sys.getenv("SPOTIFY_CLIENT_ID") == "" || Sys.getenv("SPOTIFY_CLIENT_SECRET") == "", "Spotify API credentials not available")
  result <- rec_song(genre = "invalid_genre")
  expect_equal(result, "No artists found for this genre, try again")
})

