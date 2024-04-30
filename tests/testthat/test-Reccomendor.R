# credentials object is created in helper-credentials.R

test_that("multiplication works", {
  testthat::skip_if(!credentials$found)
  expect_equal(2 * 2, 4)
})
