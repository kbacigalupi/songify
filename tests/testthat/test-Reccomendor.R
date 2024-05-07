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

# Tests that the print.song function formats a song with duration and author
test_that("print.song formats a song with duration and author", {
  song_obj <- new_song(
    title = "Test Song",
    author = "Test Artist",
    duration = 360,
    genre = "Test Genre",
    danceability = 0.5,
    energy = 0.7,
    key = "C major",
    tempo = 120
  )
  printed_output <- capture.output(print.song(song_obj))
  actual_output <- printed_output[1]
  actual_output <- gsub("^\\[1\\] \"(.*)\"$", "\\1", actual_output)
  expected_output <- "Test Song, Test Artist.................6:00"
  expect_equal(actual_output, expected_output)
})

# Tests that print.song returns a character vector
test_that("print.song returns a character vector", {
  song_obj <- new_song(
    title = "Test Song",
    author = "Test Artist",
    duration = 360,
    genre = "Test Genre",
    danceability = 0.5,
    energy = 0.7,
    key = "C major",
    tempo = 120
  )
  expect_type(song_obj, "character")
})

# Tests that summary.song returns a data frame with the correct column names
test_that("summary.song returns data frame with correct column names", {
  song_obj <- new_song(
    title = "Test Song",
    author = "Test Artist",
    duration = 360,
    genre = "Test Genre",
    danceability = 0.5,
    energy = 0.7,
    key = "C major",
    tempo = 120
  )
  summary_output <- summary.song(song_obj)
  expected_cols <- c("song", "Genre", "Danceability", "Energy", "Key", "Tempo")
  expect_equal(colnames(summary_output), expected_cols)
})

# Tests that summary.song returns a list
test_that("summary.song returns a list", {
  song_obj <- new_song(
    title = "Test Song",
    author = "Test Artist",
    duration = 360,
    genre = "Test Genre",
    danceability = 0.5,
    energy = 0.7,
    key = "C major",
    tempo = 120
  )
  summary_output <- summary.song(song_obj)
  expect_type(summary_output, "list")
})
