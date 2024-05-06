# credentials object is created in helper-credentials.R

# Tests that the function returns a character string
test_that("rec_song returns a character string for valid input", {
  result <- rec_song(genre = "rock", mode = 1, energy = 0.8, valence = 0.7)
  expect_type(result, "character")
})

# Tests if the user inputs an invalid genre
test_that("rec_song handles invalid genre", {
  result <- rec_song(genre = "invalid_genre")
  expect_equal(result, "No artists found for this genre, try again")
})

# Tests if the recommender function can handle missing API credentials
test_that("rec_song handles missing API credentials", {
  Sys.setenv(SPOTIFY_CLIENT_ID = "invalid")
  Sys.setenv(SPOTIFY_CLIENT_SECRET = "invalid")
  expect_error(
    rec_song(genre = "rock"),
    regexp = "No valid spotify API credentials found"
  )
})
